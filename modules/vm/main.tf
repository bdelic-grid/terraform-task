resource "google_compute_instance" "temp_vm" {
  name                    = var.vm
  machine_type            = var.machine_type
  zone                    = var.zone
  metadata_startup_script = file(var.startup_script)
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    subnetwork = var.subnet
    access_config {

    }
  }
}

resource "null_resource" "wait_for_script" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
  depends_on = [google_compute_instance.temp_vm]
}

resource "google_compute_snapshot" "snapshot" {
  name        = var.snapshot
  source_disk = google_compute_instance.temp_vm.boot_disk[0].source
  depends_on  = [null_resource.wait_for_script]
}

resource "google_compute_image" "snapshot_image" {
  name            = var.snapshot_image
  source_snapshot = google_compute_snapshot.snapshot.self_link
}