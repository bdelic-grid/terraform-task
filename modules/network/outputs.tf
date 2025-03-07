output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}

output "vpc_id" {
  value = google_compute_network.vpc.id
}