resource "google_compute_snapshot" "snapshot" {
  name = var.snapshot
  source_disk = var.snapshot_source
}

resource "google_compute_image" "snapshot_image" {
  name = var.image
  source_snapshot = google_compute_snapshot.snapshot.self_link
}

resource "google_compute_instance_template" "instance_template" {
  name = var.instance_template
  machine_type = var.machine_type
  tags = ["allow-health-check"]
  metadata_startup_script = file(var.instance_group_startup_script)
  disk {
    source_image = google_compute_image.snapshot_image.self_link
    boot = true
  } 
  network_interface {
    subnetwork = var.subnet
  }
}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  base_instance_name = var.instance_group_base_name
  name = var.instance_group
  zone = var.zone
  target_size = var.target_size
  version {
    instance_template = google_compute_instance_template.instance_template.self_link_unique
  }
  named_port {
    name = "http"
    port = 80
  }
}