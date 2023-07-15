resource "aws_iam_user" "user" {
  name = var.user
  path = "/${var.env}/${var.app}/${var.user}"

  tags = {
    environment = var.env
  }
}

resource "aws_iam_access_key" "ssh-access" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_group_membership" "deploy" {
  user = aws_iam_user.user.name

  groups = [
    aws_iam_group.group-acm.name,
    aws_iam_group.group-cloudfront.name,
    aws_iam_group.group-tf-state.name,
    aws_iam_group.group-s3.name,
    aws_iam_group.group-route53.name
  ]
}
