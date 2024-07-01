output "project_id" {
  value = module.bitmovin_cloud_connect.project_id
}

output "service_account_email" {
  value = module.bitmovin_cloud_connect.service_account_email
}

output "private_key" {
  value     = module.bitmovin_cloud_connect.private_key
  sensitive = true
}

# output a message guiding users on handling the private key securely
output "private_key_instructions" {
  value = "To see your private key, run `terraform output -json`. Handle credentials carefully."
}

output "network_id" {
  value = module.bitmovin_cloud_connect.network_id
}

output "subnet_id_instructions" {
  value = "To find your region's subnet id, please go to https://console.cloud.google.com/networking/networks/list"
}
