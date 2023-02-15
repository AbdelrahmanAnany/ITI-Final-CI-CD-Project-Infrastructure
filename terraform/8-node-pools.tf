  resource "google_container_node_pool" "nodepool-abdelrahman" {
    name       = "nodepool-abdelrahman"
    location   = "us-central1-a"
    cluster    = google_container_cluster.private-cluster.id
    node_count = 1

    node_config {
      preemptible  = true
      machine_type = "e2-micro"
      # custom service account
      service_account = google_service_account.service-account.email
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }