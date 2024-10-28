data "google_project" "bitmovin_project" {}

output "project_id" {
  value = data.google_project.bitmovin_project.id
}

output "network_id" {
  value = google_compute_network.bitmovin_vpc_network.name
}

output "service_account_email" {
  value = google_service_account.bitmovin_account.email
}

output "private_key" {
  value     = google_service_account_key.mykey.name
  sensitive = true
}
