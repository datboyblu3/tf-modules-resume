###########cloudfront############################
resource "aws_iam_group" "group-cloudfront" {
  name = "${var.env}-${var.app}-group-cloudfront"
  path = "/${var.env}-${var.app}-cloudfront/"
}

resource "aws_iam_group_policy" "prod-policy-cloudfront" {
  name   = "${var.env}-${var.app}-policy-cloudfront"
  group  = aws_iam_group.group-cloudfront.name
  policy = data.aws_iam_policy_document.cloudfront.json
}

data "aws_iam_policy_document" "cloudfront" {
  statement {
    actions = [
      "cloudfront:*"
    ]

    resources = [
      "*"
    ]
  }
}
