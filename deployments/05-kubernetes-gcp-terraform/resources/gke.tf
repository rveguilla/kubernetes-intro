data "google_compute_zones" "available" {}

variable "cluster_name" {
  default = "gcp-kube-cluster"
}

variable "gcp_project_id" {
}

provider "google" {
  credentials = "${file("./resources/account.json")}"
  project     = "${var.gcp_project_id}"
  region      = "us-central1"
}

resource "google_container_cluster" "primary" {
  name = "${var.cluster_name}"
  zone = "${data.google_compute_zones.available.names[0]}"
  initial_node_count = 3

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name} --zone ${google_container_cluster.primary.zone}"
  }
}



output "cluster_name" {
  value = "${google_container_cluster.primary.name}"
}

output "primary_zone" {
  value = "${google_container_cluster.primary.zone}"
}

output "additional_zones" {
  value = "${google_container_cluster.primary.additional_zones}"
}

output "endpoint" {
  value = "${google_container_cluster.primary.endpoint}"
}

output "node_version" {
  value = "${google_container_cluster.primary.node_version}"
}
output "node_config" {
  value = "${google_container_cluster.primary.node_config}"
}

output "node_pools" {
  value = "${google_container_cluster.primary.node_pool}"
}

//terraform apply \
//-var 'kubernetes_version=1.6.7' \
//-var 'cluster_name=terraform-example-cluster' \
//-var 'region=us-west1' \
//-var 'username=MySecretUsername' \
//-var 'password=MySecretPassword'
