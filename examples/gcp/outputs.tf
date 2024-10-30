data "google_project" "bitmovin_project" {}

output "project_id" {
  value = data.google_project.bitmovin_project.id
}

output "network" {
  value = module.bitmovin_cloud_connect.network
}

output "subnets" {
  value = module.bitmovin_cloud_connect.subnets
}

output "service_account_email" {
  value = module.bitmovin_cloud_connect.service_account_email
}

output "private_key" {
  value     = module.bitmovin_cloud_connect.private_key
  sensitive = true
}
