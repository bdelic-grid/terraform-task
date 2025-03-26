output "vm_disk" {
  value = google_compute_instance.temp_vm.boot_disk[0].source
}

output "snapshot_image" {
  value = google_compute_image.snapshot_image.id
}