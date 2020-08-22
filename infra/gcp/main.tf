module "network" {
  source  = "terraform-google-modules/network/google"
  version = "1.1.0"

  network_name = "my-vpc-network"
  project_id   = var.project

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = var.cidrs
      subnet_region = var.region

    },
  ]

  secondary_ranges = {
    subnet-01 = []

  }
}

module "network_fabric-net-firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  version                 = "1.1.0"
  project_id              = var.project
  network                 = module.network.network_name
  internal_ranges_enabled = true
  internal_ranges         = var.cidr

}


# provider "google" {
#   # version = "3.7.0"

#   credentials = file("terraform-key.json")

#   project = "aicolab"
#   region  = "us-central1"
#   zone    = "us-central1-c"
# }

# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }

# resource "google_compute_instance" "vm_instance" {
#   name         = "terraform-instance"
#   machine_type = "f1-micro"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-9"
#     }
#   }

#   network_interface {
#     network = google_compute_network.vpc_network.name
#     access_config {
#     }
#   }
# }

# resource "google_compute_address" "static_ip" {
#   name = "terraform-static-ip"
# }

# terraform {
#   backend "gcs" {
#     bucket      = "terraform-ai"
#     prefix      = "terraform1"
#     credentials = "terraform-key.json"
#   }
# }
