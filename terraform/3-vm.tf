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
  #Install kubectl, dockercli , google cloud auth plugin
  metadata = {
    startup-script = <<-EOF
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    apt-get update -y && apt-get install ca-certificates curl gnupg lsb-release -y && mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
    EOF
  }
}
