resource "google_compute_instance" "temp_vm" {
  name                    = var.vm
  machine_type            = var.machine_type
  zone                    = var.zone
  metadata_startup_script = file(var.startup_script)
  boot_disk {
    auto_delete = false
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    subnetwork = var.subnet
  }
}