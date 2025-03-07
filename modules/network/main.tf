resource "google_compute_network" "vpc" {
  name                    = var.vpc
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.ip_cidr_range
  stack_type    = var.stack_type
  region        = var.region
}

resource "google_compute_firewall" "default_firewall" {
  name          = var.firewall
  network       = google_compute_network.vpc.name
  source_ranges = var.source_ranges
  allow {
    protocol = "tcp"
    ports    = var.port_list
  }
}
