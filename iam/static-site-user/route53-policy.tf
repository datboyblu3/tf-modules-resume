#############################route53############################
resource "aws_iam_group" "group-route53" {
  name = "${var.env}-${var.app}-group-route53"
  path = "/${var.env}-${var.app}-route53/"
}

resource "aws_iam_group_policy" "prod-policy-route53" {
  name   = "${var.env}-${var.app}-policy-route53"
  group  = aws_iam_group.group-route53.name
  policy = data.aws_iam_policy_document.route53.json
}

data "aws_iam_policy_document" "route53" {
  statement {
    actions = [
      "route53:*",
    ]

    resources = [
      "*"
    ]
  }
}
