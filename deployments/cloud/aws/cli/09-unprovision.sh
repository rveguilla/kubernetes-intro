#!/usr/bin/env bash

aws ecr delete-repository --repository-name example-app --force
aws eks delete-cluster --name "example-app-eks-cluster" 

aws cloudformation delete-stack --stack-name "example-app-eks-nodegroup-stack" 
aws cloudformation delete-stack --stack-name "example-app-eks-vpc-stack" 

aws ec2 delete-key-pair --key-name "example-app-eks-node-keypair" 

aws iam detach-role-policy --role-name "example-app-eks-svc-role" --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
aws iam detach-role-policy --role-name "example-app-eks-svc-role" --policy-arn arn:aws:iam::aws:policy/AmazonEKSServicePolicy

aws iam delete-role --role-name "example-app-eks-svc-role"