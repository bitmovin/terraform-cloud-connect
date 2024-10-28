data "google_project" "bitmovin_project" {}

output "project_id" {
  value = data.google_project.bitmovin_project.id
}

output "network_id" {
  value = google_compute_network.bitmovin_vpc_network.name
}

output "network" {
  value = "/global/networks/${google_compute_network.bitmovin_vpc_network.name}"
}

data "google_compute_network" "bitmovin-network" {
  name = var.network_name
  depends_on = [google_compute_network.bitmovin_vpc_network]
}

output "subnets" {
  value = data.google_compute_network.bitmovin-network.subnetworks_self_links
}

output "service_account_email" {
  value = google_service_account.bitmovin_account.email
}

output "private_key" {
  value     = google_service_account_key.mykey.name
  sensitive = true
}
