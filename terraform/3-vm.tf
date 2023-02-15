#create private VM instance
resource "google_compute_instance" "private-instance" {
  name         = "private-instance"
  machine_type = "e2-small"
  zone         = "us-central1-a"

  #Debian Image to run kubectl
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "private-instance"
      }
    }

  }

  #attach private virtual machine with management subnet
  network_interface {
    network = google_compute_network.abdelrahman-vpc.id

    subnetwork = google_compute_subnetwork.management_subnet.id

  }

}
