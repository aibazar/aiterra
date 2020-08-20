provider "google" {
  version = "3.5.0"

  credentials = file("terraform-key.json")

  project = "aicolab"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

terraform {
  backend "gcs" {
    bucket = "terraform-ai"
    prefix = "terraform1/state"
  }
}
