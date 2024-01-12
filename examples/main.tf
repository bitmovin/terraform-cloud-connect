provider "aws" {
  region = "local"
}

module "bitmovin_cloud_connect" {
  source  = "./.."

  role_arn = null  #"arn:aws:iam::123456789123:role/adminRoleInYourCompany"

  user_name = "bitmovin-cloud-connect-user"
  policy_name = "bitmovin-inline-policy"
  security_group_name = "bitmovin-security-group"

  live_rtmp = false
  live_srt = false
  live_zixi = false

  live_ingress_cidr_blocks = ["0.0.0.0/0"]
  live_ingress_ipv6_cidr_blocks = ["::/0"]

  tags = {
           company = "bitmovin",
           product = "cloud-connect"
         }
}

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
