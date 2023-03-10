#creating private cluster and associate it to restricted subnet
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "private-cluster" {
  name     = "private-cluster"
  location = "us-central1-a"
  # creating node pool  
  remove_default_node_pool = true
  initial_node_count       = 3
  network                  = google_compute_network.abdelrahman-vpc.id
  subnetwork               = google_compute_subnetwork.restricted_subnet.id


  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/24"
      display_name = "managment-cidr-range"
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.30.0.0/16"
    services_ipv4_cidr_block = "10.20.0.0/16"
  }


  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "192.16.0.0/28"
  }

}

resource "google_container_node_pool" "nodepool-project" {
  name       = "nodepool-project"
  location   = "us-central1-a"
  cluster    = google_container_cluster.private-cluster.id
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    # custom service account
    service_account = google_service_account.project-service-account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
