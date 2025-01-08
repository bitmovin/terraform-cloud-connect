locals {
  project_id = "{{YOUR_PROJECT_ID}}"
}

provider "google" {
  project = local.project_id
}

module "bitmovin_cloud_connect" {
  project_id = local.project_id
  source     = "../../modules/gcp" # local reference when you clone the repository
  # source     = "github.com/bitmovin/terraform-cloud-connect//modules/gcp" # remote GitHub reference

  # For all possible input variables, please check:
  # Documentation: https://github.com/bitmovin/terraform-cloud-connect/blob/main/README.md#inputs
}

module "bitmovin_cloud_connect_with_specific_subnets" {
  project_id = local.project_id
  source     = "github.com/bitmovin/terraform-cloud-connect//modules/gcp"

  network_name = "selected-subnet-regions-only"
  enabled_regions = [
    { "region" : "us-central1", "cidr" : "10.128.0.0/20" }
  ]
}
