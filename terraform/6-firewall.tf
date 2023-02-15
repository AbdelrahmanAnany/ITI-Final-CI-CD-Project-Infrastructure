resource "google_compute_firewall" "firewall" "allow-ssh" {
  name          = "allow-ssh"
  source_ranges = ["0.0.0.0/0"]
  network       = google_compute_network.abdelrahman-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}
