locals {
  project_id = "{{YOUR_PROJECT_ID}}"
}

provider "google" {
  project = local.project_id
}

module "bitmovin_cloud_connect" {
  project_id = local.project_id
  source     = "../../modules/gcp"

  # For all possible input variables, please check:
  # Documentation: https://github.com/bitmovin/terraform-cloud-connect/blob/main/README.md#inputs
}
