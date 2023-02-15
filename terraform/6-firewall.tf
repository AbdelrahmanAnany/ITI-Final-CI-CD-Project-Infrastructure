resource "google_compute_firewall" "firewall" {
  name          = "firewall"
  source_ranges = ["0.0.0.0/0"]
  network       = google_compute_network.abdelrahman-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}
