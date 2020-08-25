# Using Terraform to Create Compute Engine Instances
provider "google" {
  version = "3.5.0"

  credentials = file("terraform-key.json")

  project = var.project
  region  = var.region
  zone    = "us-central1-a"
}

resource "google_compute_network" "vpc_network" {
  name = "new-terraform-network"
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-host"
  machine_type = "f1-micro"
  tags         = ["web"]
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.vpc_default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags   = ["web"]
  source_ranges = ["0.0.0.0/0"]
}


## Using Terraform to Create a new VPC
# module "network" {
#   source  = "terraform-google-modules/network/google"
#   version = "2.1.1"

#   network_name = "my-vpc-network"
#   project_id   = var.project

#   subnets = [
#     {
#       subnet_name   = "subnet-01"
#       subnet_ip     = var.cidrs
#       subnet_region = var.region

#     },
#     # { 
#     #   subnet_name   = "subnet-02"
#     #   subnet_ip     = 10.1.0.0/16
#     #   subnet_region = var.region
#     #   google_private_access = "true"  # private subnet 
#     # },
#   ]

#   secondary_ranges = {
#     subnet-01 = []
#   }
# }

# module "network_routes" {
#   source       = "terraform-google-modules/network/google//modules/routes"
#   version      = "2.1.1"
#   network_name = module.network.network_name
#   project_id   = var.project

#   routes = [
#     {
#       name              = "egress-internet"
#       description       = "route through IGW to access internet"
#       destination_range = "0.0.0.0/0"
#       tags              = "egress-inet"
#       next_hop_internet = "true"
#     },

#   ]
# }


# module "network_fabric-net-firewall" {
#   source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
#   version                 = "1.1.0"
#   project_id              = var.project
#   network                 = module.network.network_name
#   internal_ranges_enabled = true
#   internal_ranges         = var.cidrs

# }


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
