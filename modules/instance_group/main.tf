resource "google_compute_instance_template" "instance_template" {
  name         = var.instance_template
  machine_type = var.machine_type
  tags         = ["allow-health-check"]
  metadata_startup_script = file("./instance_group_startup_script.sh")
  disk {
    source_image = var.snapshot_image
    boot         = true
  }
  network_interface {
    subnetwork = var.subnet
  }
}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  base_instance_name = var.instance_group_base_name
  name               = var.instance_group
  zone               = var.zone
  target_size        = var.target_size
  version {
    instance_template = google_compute_instance_template.instance_template.self_link_unique
  }
  named_port {
    name = "http"
    port = 80
  }
}