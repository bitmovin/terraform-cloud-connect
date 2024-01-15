# terraform-cloud-connect

## Description

The main purpose of this script is to create an IAM User with enough permission and a Security Group with correct Inbound and Outbound rules so that Bitmovin's Cloud Connect product will be able to run Video Encodings in the configured infrastructure.

The Terraform Cloud Connect module does the following:

- Creates new IAM user
- Assigns required permission for Cloud-Connect: approx. AmazonEC2FullAccess
- Creates a Security Group
- Adds required Inbound and Outbound rules
- Outputs:
    - Account Id
    - Access Key
    - Secret Access Key
    - Security Group Id

The outputs that are produced by the script can be used in a next step to configure the Bitmovin Encoder for Cloud Connect.

## Provider

**Important**
- The script currently supports only one provider and one region at a time. 
- Please specify the desired region where you expect your encodings to run. 
- Additionally, provide the roles that may grant account creation rights for the specified provider.

## Usage

Install Terraform: 

https://developer.hashicorp.com/terraform/install

Run:

````
terraform init
terraform plan
terraform apply
````

You can use the Bitmovin Cloud Connect Terraform module like this:

````
provider "aws" {
  region   = "eu-west-1"
  role_arn = "arn:aws:iam::123456789012:role/roleWithAccountCreationRights"
}

module "bitmovin_cloud_connect" {
  source  = "github.com/bitmovin/terraform-cloud-connect/modules/aws"
}
````

For all possible configurations, please check [Inputs](#inputs).

Based on [Bitmovin Cloud Connect Configuration](https://developer.bitmovin.com/encoding/docs/using-bitmovin-cloud-connect-with-aws#configure-your-bitmovin-account), we need the following output:

````
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
````

Print out the outputs:

````
terraform output -json
````

Remove the created resources with the following commands:

````
terraform destroy
````

**Warning**: using the above command will remove the user, policy, security group and rules needed for the Bitmovin Cloud Connect product to work. Use the destroy command when you want to stop using the previously created resources.

## Inputs

| Input        | Description           | Type  | Default  |
| :------------|:----------------------|:------|:---------|
| user_name | Name of the IAM user that will be created | string | "bitmovin-cloud-connect-user"|
| policy_name | Name of the Policy that will be created | string |  "bitmovin-inline-policy" |
| security_group_name | Name of the Security Group that will be created | string | "bitmovin-security-group" |
| | | | |
| live_rtmp | Prepare live RTMP by setting the correct ingress rules | bool | false |
| live_srt | Prepare live SRT by setting the correct ingress rules | bool | false |
| live_zixi | Prepare live Zixi by setting the correct ingress rules | bool | false |
| | | | |
| live_ingress_cidr_blocks | Allowed ingress IPv4 used for live (RTMP, SRT, Zixi) | list(string) | ["0.0.0.0/0"] |
| live_ingress_ipv6_cidr_blocks | Allowed ingress IPv6 used for live (RTMP, SRT, Zixi) | list(string) | ["::/0"] |
| | | | |
| tags | Tags that will be attached to the created resources | map | { company = "bitmovin", product = "cloud-connect" } |

## Examples

[AWS Example](https://github.com/bitmovin/terraform-cloud-connect/tree/main/examples/aws) - Use Bitmovin AWS Cloud Connect.
