locals {
  project_id = "tischler-terraform-testing"
}

provider "google" {
  project = local.project_id
}

module "bitmovin_cloud_connect" {
  project_id = local.project_id
  source     = "../../modules/gcp" # local reference when you clone the repository
  # source     = "github.com/bitmovin/terraform-cloud-connect/blob/main/modules/gcp" # remote GitHub reference

  # For all possible input variables, please check:
  # Documentation: https://github.com/bitmovin/terraform-cloud-connect/blob/main/README.md#inputs
}
