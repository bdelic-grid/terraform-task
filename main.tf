terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.24.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.3"
    }
  }
}

provider "google" {
  project = var.project
  region = var.region
  zone = var.zone
}

provider "null" {
}

//NETWORK

resource "google_compute_network" "vpc" {
  name = "bdelic-terraform-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name = "bdelic-terraform-subnet"
  ip_cidr_range = "10.2.0.0/24"
  stack_type = "IPV4_ONLY"
  region = var.region
  network = google_compute_network.vpc.id
  depends_on = [ google_compute_network.vpc ]
}

resource "google_compute_firewall" "default_firewall" {
  name = "bdelic-terraform-firewall"
  network = google_compute_network.vpc.name
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports = ["22", "443", "8080"]
  }
}


// VM

resource "google_compute_instance" "temp_vm" {
  name = "bdelic-terraform-instance"
  machine_type = "e2-micro"
  zone = var.zone
  metadata_startup_script = file(var.startup_script)
  depends_on = [ google_compute_subnetwork.subnet ]
  boot_disk {
    auto_delete = false
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
    }
  }
}

resource "null_resource" "turn_off_vm" {
  provisioner "local-exec" {
    command = "gcloud compute instances stop bdelic-terraform-instance --zone=us-central1-a"
  }
  depends_on = [ google_compute_snapshot.snapshot ]
}

resource "google_compute_snapshot" "snapshot" {
  name = "bdelic-terraform-snapshot"
  source_disk = google_compute_instance.temp_vm.boot_disk[0].source
  depends_on = [ google_compute_instance.temp_vm ]
}

resource "google_compute_image" "snapshot_image" {
  name = "bdelic-snapshot-image"
  source_snapshot = google_compute_snapshot.snapshot.self_link
  depends_on = [ google_compute_snapshot.snapshot ]
}

resource "google_compute_instance_template" "instance_template" {
  name = "bdelic-terraform-instance-template"
  machine_type = "e2-micro"
  tags = ["allow-health-check"]
  depends_on = [ google_compute_snapshot.snapshot ]
  disk {
    source_image = google_compute_image.snapshot_image.self_link
    boot = true
  } 
  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
    }
  }
}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  base_instance_name = "bdelic-terraform-group-instance"
  name = "bdelic-instance-group-manager"
  zone = var.zone
  target_size = 3
  depends_on = [ google_compute_instance_template.instance_template ]
  version {
    instance_template = google_compute_instance_template.instance_template.self_link_unique
  }
  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_firewall" "healthcheck_firewall" {
  name = "bdelic-terraform-healthcheck-firewall"
  network = google_compute_network.vpc.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["allow-health-check"]
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  depends_on = [ google_compute_network.vpc ]
}

resource "google_compute_global_address" "load_balancer_ip" {
  name = "bdelic-lb-ip"
  ip_version = "IPV4"
  depends_on = [ google_compute_instance_group_manager.instance_group_manager ]
}

resource "google_compute_health_check" "healthcheck" {
  name               = "bdelic-http-basic-check"
  check_interval_sec = 5
  healthy_threshold  = 2
  http_health_check {
    port               = 80
    port_specification = "USE_FIXED_PORT"
    proxy_header       = "NONE"
    request_path       = "/"
  }
  timeout_sec         = 5
  unhealthy_threshold = 2
  depends_on = [ google_compute_global_address.load_balancer_ip ]
}

resource "google_compute_backend_service" "backend" {
  name                            = "bdelic-backend"
  connection_draining_timeout_sec = 0
  health_checks                   = [google_compute_health_check.healthcheck.id]
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  port_name                       = "http"
  protocol                        = "HTTP"
  session_affinity                = "NONE"
  timeout_sec                     = 30
  backend {
    group           = google_compute_instance_group_manager.instance_group_manager.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  depends_on = [ google_compute_health_check.healthcheck ]
}

resource "google_compute_url_map" "url_map" {
  name            = "bdelic-map"
  default_service = google_compute_backend_service.backend.id
  depends_on = [ google_compute_backend_service.backend ]
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "bdelic-http-lb-proxy"
  url_map = google_compute_url_map.url_map.id
  depends_on = [ google_compute_url_map.url_map ]
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name                  = "bdelic-http-content-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80-80"
  target                = google_compute_target_http_proxy.http_proxy.id
  ip_address            = google_compute_global_address.load_balancer_ip.id
  depends_on = [ google_compute_target_http_proxy.http_proxy ]
}
