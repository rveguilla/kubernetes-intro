#!/usr/bin/env bash

aws iam create-role --role-name "example-app-eks-svc-role" --assume-role-policy-document file://resources/eks-role-trusted-policy.json
aws iam attach-role-policy --role-name "example-app-eks-svc-role" --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
aws iam attach-role-policy --role-name "example-app-eks-svc-role" --policy-arn arn:aws:iam::aws:policy/AmazonEKSServicePolicy
aws cloudformation create-stack --stack-name "example-app-eks-vpc-stack" --template-body file://resources/amazon-eks-vpc-sample.yaml
sleep 120

ROLE_ARN=$(aws iam get-role --role-name "example-app-eks-svc-role" --query "Role.Arn" --output text)
SUBNETS_ID=$(aws ec2 describe-subnets --filter "Name=tag-key,Values=aws:cloudformation:stack-name" "Name=tag-value,Values=example-app-eks-vpc-stack" --query "Subnets[].SubnetId" --output text | sed -e 's/[[:space:]]/,/g' )
SECURITY_GROUPS_ID=$(aws ec2 describe-security-groups --filter "Name=tag-key,Values=aws:cloudformation:stack-name" "Name=tag-value,Values=example-app-eks-vpc-stack" --query "SecurityGroups[].GroupId" --output text | sed -e 's/[[:space:]]/,/g' )
VPC_ID=$(aws ec2 describe-vpcs --filter "Name=tag-key,Values=aws:cloudformation:stack-name" "Name=tag-value,Values=example-app-eks-vpc-stack" --query "Vpcs[0].VpcId" --output text)

aws eks create-cluster --name "example-app-eks-cluster" --role-arn ${ROLE_ARN} --resources-vpc-config subnetIds=${SUBNETS_ID},securityGroupIds=${SECURITY_GROUPS_ID}

aws ec2 create-key-pair --key-name "example-app-eks-node-keypair" --query "KeyMaterial" --output text >  ./output/example-app-eks-node-keypair

aws cloudformation create-stack --stack-name "example-app-eks-nodegroup-stack" --template-body file://resources/amazon-eks-nodegroup.yaml \
    --capabilities CAPABILITY_IAM \
    --parameters \
            ParameterKey=ClusterName,ParameterValue=example-app-eks-cluster \
            ParameterKey=ClusterControlPlaneSecurityGroup,ParameterValue=${SECURITY_GROUPS_ID} \
            ParameterKey=VpcId,ParameterValue=${VPC_ID} \
            ParameterKey=Subnets,ParameterValue=\"${SUBNETS_ID}\" \
            ParameterKey=NodeGroupName,ParameterValue=example-app-eks-nodegroup \
            ParameterKey=NodeAutoScalingGroupMinSize,ParameterValue=3 \
            ParameterKey=NodeAutoScalingGroupMaxSize,ParameterValue=3 \
            ParameterKey=NodeInstanceType,ParameterValue=t2.small \
            ParameterKey=NodeImageId,ParameterValue=ami-0a0b913ef3249b655 \
            ParameterKey=KeyName,ParameterValue=example-app-eks-node-keypair

sleep 180

export NODEGROUP_ROLE_ARN=$(aws cloudformation describe-stacks --stack-name "example-app-eks-nodegroup-stack" --query "Stacks[0].Outputs[0].OutputValue" --output text)

aws eks update-kubeconfig --name "example-app-eks-cluster"

cat resources/aws-auth-cm.yaml | envsubst | kubectl apply -f - 

kubectl apply -f resources/gp2-storage-class.yaml
kubectl patch storageclass gp2 -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/service-l4.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/patch-configmap-l4.yaml
