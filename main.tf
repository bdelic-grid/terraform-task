terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project
  region = var.region
}

resource "google_compute_network" "vpc" {
  name = "bdelic-terraform-vpc"
}

resource "google_compute_instance" "vm" {
  name = "bdelic-terraform-instance"
  machine_type = "e2-micro"
  zone = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc.name
    access_config {
    }
  }
}