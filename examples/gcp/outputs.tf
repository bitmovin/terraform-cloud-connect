output "project_id" {
  value = local.project_id
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
  value = module.bitmovin_cloud_connect.network
}

output "subnet_ids" {
  value = module.bitmovin_cloud_connect.subnets
}