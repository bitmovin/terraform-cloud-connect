module "bitmovin_cloud_connect" {
  source  = "./.."

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
