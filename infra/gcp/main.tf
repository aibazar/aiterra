provider "google" {
  # version = "3.7.0"

  credentials = file("terraform-key.json")

  project = "aicolab"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_address" "static_ip" {
  name = "terraform-static-ip"
}

# terraform {
#   backend "gcs" {
#     bucket      = "terraform-ai"
#     prefix      = "terraform1"
#     credentials = "terraform-key.json"
#   }
# }
