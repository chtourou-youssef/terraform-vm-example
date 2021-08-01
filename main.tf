resource "google_compute_subnetwork" "subnetlan" {  
  name          = var.subnet-name
  ip_cidr_range = "172.16.24.0/24"
  region        = var.region
  network       = google_compute_network.lan.id
}

resource "google_compute_network" "lan" {
  name = var.network-name
}

resource "google_compute_instance" "vm" {
  name         = var.vmname
  machine_type = "e2-medium"
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  
  network_interface {
    network = google_compute_network.lan.name
    subnetwork = google_compute_subnetwork.subnetlan.name
    access_config {
    }
  }
    
  tags = ["web"] 
   
  metadata = {
    ssh-keys = "${var.user}:${file(var.sshpath)}"
  }

  metadata_startup_script = <<-EOF
  sudo apt -y update
  sudo apt -y install apache2
  sudo ufw allow 80/tcp
  EOF
}

resource "google_compute_firewall" "lan-firewall" {
  name    = "test-firewall"
  network = google_compute_network.lan.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
  source_tags = ["web"]
}
