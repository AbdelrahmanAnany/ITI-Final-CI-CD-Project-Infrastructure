# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private" {
  name                     = "private"
  ip_cidr_range            = "10.0.0.0/18"
  region                   = "us-central1"
  network                  = google_compute_network.main.id
    #allow private google access to communicate with gcp resources
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/14"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/20"
  }
}

# #create management subnet for VM
# resource "google_compute_subnetwork" "management_subnet" {
#   name          = "management-subnet"
#   ip_cidr_range = "10.0.0.0/24"
#   region        = "us-central1"
#   network       = google_compute_network.abdelrahman-vpc.id
# }

# #create restricted subnet for GKE
# resource "google_compute_subnetwork" "restricted_subnet" {
#   name          = "restricted-subnet"
#   ip_cidr_range = "10.0.1.0/24"
#   region        = "us-central1"
#   network       = google_compute_network.abdelrahman-vpc.id

#   #allow private google access to communicate with gcp resources
#   private_ip_google_access = true
# }