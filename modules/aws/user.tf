resource "aws_iam_user" "ec2_user" {
  name = var.user_name
  tags = var.tags
}

resource "aws_iam_policy" "inline_policy" {
  description = "Required permissions for Bitmovin Cloud Connect"
  name        = var.policy_name
  policy      = jsondecode(file("${path.module}/permissions.json"))
  tags        = var.tags
}

resource "aws_iam_user_policy_attachment" "ec2_user_attachment" {
  user       = aws_iam_user.ec2_user.name
  policy_arn = aws_iam_policy.inline_policy.arn
}

resource "aws_iam_access_key" "ec2_user_access_key" {
  user = aws_iam_user.ec2_user.name
}
