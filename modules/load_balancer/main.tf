resource "google_compute_firewall" "healthcheck_firewall" {
  name          = var.healthcheck_firewall
  network       = var.vpc_id
  source_ranges = var.source_ranges
  target_tags   = ["allow-health-check"]
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
}

resource "google_compute_global_address" "load_balancer_ip" {
  name       = var.lb_ip
  ip_version = var.ip_version
}

resource "google_compute_health_check" "healthcheck" {
  name               = var.healthcheck
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
}

resource "google_compute_backend_service" "backend" {
  name                            = var.backend
  connection_draining_timeout_sec = 0
  health_checks                   = [google_compute_health_check.healthcheck.id]
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  port_name                       = "http"
  protocol                        = "HTTP"
  session_affinity                = "NONE"
  timeout_sec                     = 30
  backend {
    group           = var.instance_group_manager_instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_url_map" "url_map" {
  name            = var.url_map
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = var.proxy
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name                  = var.forwarding_rule
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = var.port_range
  target                = google_compute_target_http_proxy.http_proxy.id
  ip_address            = google_compute_global_address.load_balancer_ip.id
}