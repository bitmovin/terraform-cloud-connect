resource "aws_security_group" "security_group" {
  name        = var.security_group_name
  tags        = var.tags
  description = "Security group setting the Ingress and Egress rules for Bitmovin Cloud Connect"
}
