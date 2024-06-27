# terraform-cloud-connect

The main purpose of these scripts is to create the necessary resources and permissions to get you started with Bitmovin Cloud Connect.

## What's inside?

### AWS

The AWS module will create the following resources to enable running encoding jobs with Bitmovin Cloud Connect:

- Creates a new IAM user
- Assigns the required permission for Cloud-Connect: approx. `AmazonEC2FullAccess`
- Creates a Security Group
- Adds the required Inbound and Outbound rules
- Outputs:
  - Account Id
  - Access Key
  - Secret Access Key
  - Security Group Id

The outputs that are produced by the script can be used in a next step to configure the [Bitmovin Encoder for Cloud Connect](https://developer.bitmovin.com/encoding/docs/using-bitmovin-cloud-connect-with-aws#configure-your-bitmovin-account).

### GCP

The GCP module will create the following resources to enable running encoding jobs with Bitmovin Cloud Connect:

- Enable the Compute Engine API
- Creates a new Service Account
  - with the permissions of role `roles/compute.instanceAdmin.v1`
  - with an Access Key
- Creates a new auto-mode VPC network
- Creates the required firewall rules
- Outputs:
  - Project ID
  - Service Account Email
  - Private Key (instructions)
  - Network ID
  - Subnet ID instructions

## Provider

**Important**

- The script currently supports only one provider and one region at a time.
- (AWS only) Please specify the desired region where you expect your encodings to run.
- (AWS only) Additionally, provide the roles that may grant account creation rights for the specified provider.

## Usage

Install Terraform and the provider of your choice:

- Terraform https://developer.hashicorp.com/terraform/install
- provider of your choice
  - AWS https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build
  - GCP https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build

Run:

```
terraform init
terraform plan
terraform apply
```

You can use the Bitmovin Cloud Connect Terraform module like this:

```terraform
# examples/aws/main.tf
provider "aws" {
  region   = "eu-west-1"
  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/roleWithAccountCreationRights"
  }
}

module "bitmovin_cloud_connect" {
  source  = "github.com/bitmovin/terraform-cloud-connect/blob/main/modules/aws"
}
```

```terraform
# examples/gcp/main.tf
locals {
  project_id = "your GCP Project ID"
}

provider "google" {
  project = local.project_id
}

module "bitmovin_cloud_connect" {
  project_id = local.project_id
  source     = "github.com/bitmovin/terraform-cloud-connect/blob/main/modules/gcp"
}
```

For all possible configurations, please check [Inputs](#inputs).

Based on the selected provider module, the script will output different information. This information is relevant to connect your infrastructure with Bitmovin Cloud Connect:

- [Configure your Bitmovin account with AWS](https://developer.bitmovin.com/encoding/docs/using-bitmovin-cloud-connect-with-aws#configure-your-bitmovin-account)
- [Configure your Bitmovin account with GCP](https://developer.bitmovin.com/encoding/docs/using-bitmovin-cloud-connect-with-gcp#configure-your-bitmovin-account)

Print out the outputs:

```
terraform output -json
```

Remove the created resources with the following commands:

```
terraform destroy
```

**Warning**: using the command above will remove the created Terraform-managed resources for Bitmovin Cloud Connect to work. Use the `destroy` command only when you are sure you want to stop using the previously created resources.

## Inputs

## All providers

| Input                            | Description                                            | Type         | Default       |
| :------------------------------- | :----------------------------------------------------- | :----------- | :------------ |
| live_rtmp                        | Prepare live RTMP by setting the correct ingress rules | bool         | false         |
| live_srt                         | Prepare live SRT by setting the correct ingress rules  | bool         | false         |
| live_zixi                        | Prepare live Zixi by setting the correct ingress rules | bool         | false         |
| live_ingress_ipv4_network_blocks | Allowed ingress IPv4 used for live (RTMP, SRT, Zixi)   | list(string) | ["0.0.0.0/0"] |
| live_ingress_ipv6_network_blocks | Allowed ingress IPv6 used for live (RTMP, SRT, Zixi)   | list(string) | ["::/0"]      |

## AWS-only

| Input               | Description                                         | Type   | Default                                             |
| :------------------ | :-------------------------------------------------- | :----- | :-------------------------------------------------- |
| user_name           | Name of the IAM user that will be created           | string | "bitmovin-cloud-connect"                            |
| policy_name         | Name of the Policy that will be created             | string | "bitmovin-cloud-connect"                            |
| security_group_name | Name of the Security Group that will be created     | string | "bitmovin-cloud-connect"                            |
| tags                | Tags that will be attached to the created resources | map    | { company = "bitmovin", product = "cloud-connect" } |

## GCP-only

| Input                 | Description                                                       | Type   | Default                       |
| :-------------------- | :---------------------------------------------------------------- | :----- | :---------------------------- |
| project_id (required) | Project ID of the Bitmovin project for Cloud Connect Encoding     | string |                               |
| account_id            | Account ID of the Service Account user for Cloud Connect Encoding | string | "bitmovin-cloud-connect-user" |
| user_name             | Name of the Service Account user for Cloud Connect Encoding       | string | "bitmovin-cloud-connect-user" |
| network_name          | Auto-mode VPC network for Cloud Connect Encoding                  | string | "bitmovin-cloud-connect"      |

## Examples

- [Use Bitmovin Cloud Connect with AWS](https://github.com/bitmovin/terraform-cloud-connect/tree/main/examples/aws)
- [Use Bitmovin Cloud Connect with GCP](https://github.com/bitmovin/terraform-cloud-connect/tree/main/examples/gcp)
