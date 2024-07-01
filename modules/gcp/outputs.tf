data "google_project" "bitmovin_project" {}

output "project_id" {
  value = data.google_project.bitmovin_project.id
}

data "google_compute_network" "bitmovin_network" {
  name = var.network_name
}

output "network_id" {
  value = data.google_compute_network.bitmovin_network.name
}

data "google_service_account" "bitmovin_account" {
  account_id = var.account_id
}

output "service_account_email" {
  value = data.google_service_account.bitmovin_account.email
}

data "google_service_account_key" "mykey" {
  name = google_service_account_key.mykey.name
}

output "private_key" {
  value     = data.google_service_account_key.mykey
  sensitive = true
}
