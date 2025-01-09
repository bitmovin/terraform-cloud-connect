output "project_id" {
  value = local.project_id
}

output "service_account_email" {
  value = module.bitmovin_cloud_connect.service_account_email
}

# partially resembles JSON key file
resource "local_file" "service_account_key_file" {
  content = jsonencode({
    "type" : "service_account"
    "project_id" : local.project_id
    "private_key" : jsondecode(base64decode(module.bitmovin_cloud_connect.private_key))["private_key"]
    "client_email" : module.bitmovin_cloud_connect.service_account_email
  })
  filename = "${path.module}/${local.project_id}-${substr(jsondecode(base64decode(module.bitmovin_cloud_connect.private_key))["private_key_id"], 0, 12)}.json"
}

# output a message guiding users on handling the private key securely
output "private_key_instructions" {
  value = "To see your private key, open the generated JSON output file. Handle credentials carefully."
}

output "network_id" {
  value = module.bitmovin_cloud_connect.network
}

output "subnet_ids" {
  value = module.bitmovin_cloud_connect.subnets
}
