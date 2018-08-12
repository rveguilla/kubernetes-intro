
terraform {
  backend "gcs" {
    prefix  = "terraform/state"
  }
}

variable "google_compute_region"  {
  default = "us-central1"
}

variable "google_compute_zone" {
  default = "us-central1-a"
}

provider "google" {
  region = "${var.google_compute_region}"
}

variable "cluster_name" {
  default = "exampleapp-kube-cluster"
}

variable "node_count" {
  default = "3"
}

resource "google_container_cluster" "primary" {
  name = "${var.cluster_name}"
  zone = "${var.google_compute_zone}"
  initial_node_count = "${var.node_count}"

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