output "account_id" {
  value = module.bitmovin_cloud_connect.account_id
}

output "access_key" {
  value = module.bitmovin_cloud_connect.access_key
}

output "secret_access_key" {
  value     = module.bitmovin_cloud_connect.secret_access_key
  sensitive = true
}

output "security_group_id" {
  value = module.bitmovin_cloud_connect.security_group_id
}