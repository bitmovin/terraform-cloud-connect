data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "access_key" {
  value = aws_iam_access_key.ec2_user_access_key.id
}

output "secret_access_key" {
  value = aws_iam_access_key.ec2_user_access_key.secret
  sensitive = true
}

output "security_group_id" {
  value = aws_security_group.security_group.id
}
