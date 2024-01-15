provider "aws" {
  region = "eu-west-1"
}

module "bitmovin_cloud_connect" {
  source  = "github.com/bitmovin/terraform-cloud-connect/modules/aws"

  # For all possible input variables, please check:
  # Documentation: https://github.com/bitmovin/terraform-cloud-connect/blob/main/README.md#inputs
}
