output "vpc_network_id" {
  description = "The ID of the VPC network."
  value       = google_compute_network.vpc_network.id
}

output "subnets" {
  description = "A map of subnets created, keyed by name."
  value       = google_compute_subnetwork.subnets
}
