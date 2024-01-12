locals {
  permissions_json = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:TerminateInstances",
        "ec2:StartInstances",
        "ec2:CreateTags",
        "ec2:RunInstances",
        "ec2:StopInstances"
      ],
      "Resource": [
        "arn:aws:ec2:*:*:subnet/*",
        "arn:aws:ec2:*:*:instance/*",
        "arn:aws:ec2:*:*:volume/*",
        "arn:aws:ec2:*:*:security-group/*",
        "arn:aws:ec2:*:*:network-interface/*",
        "arn:aws:ec2:*::image/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:RequestSpotInstances",
        "ec2:DescribeTags",
        "ec2:DescribeVpnConnections",
        "ec2:DescribeVolumesModifications",
        "ec2:DescribeSpotInstanceRequests",
        "ec2:DescribeSecurityGroups",
        "ec2:GetConsoleOutput",
        "ec2:DescribeSpotPriceHistory",
        "ec2:CancelSpotInstanceRequests",
        "ec2:GetPasswordData",
        "ec2:GetLaunchTemplateData",
        "ec2:DescribeScheduledInstances",
        "ec2:DescribeVpcs",
        "ec2:DescribeScheduledInstanceAvailability",
        "ec2:DescribeElasticGpus",
        "ec2:DescribeInstanceStatus"
      ],
      "Resource": "*"
    }
  ]
}
JSON
}
