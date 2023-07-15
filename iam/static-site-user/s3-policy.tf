######################For deploying S3 resources############
resource "aws_iam_group" "group-s3" {
  name = "${var.env}-${var.app}-s3-group"
  path = "/${var.env}/${var.app}-s3-group/"
}

resource "aws_iam_group_policy" "policy-s3-deploy" {
  name   = "${var.env}-${var.app}-s3-deploy"
  group  = aws_iam_group.group-s3.name
  policy = data.aws_iam_policy_document.s3-deploy.json
}



data "aws_iam_policy_document" "s3-deploy" {
  statement {
    actions = [
      "s3:*"
    ]

    resources = [
      "*"
    ]
  }
}
