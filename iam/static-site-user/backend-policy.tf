data "aws_caller_identity" "current" {}


#######################s3 remote state######################
resource "aws_iam_group" "group-tf-state" {
  name = "${var.env}-${var.app}-group-remote-backend"
  path = "/${var.env}/${var.app}-group-remote-backend/"
}

resource "aws_iam_group_policy" "policy-tf-state-s3" {
  name   = "${var.env}-${var.app}-tf-state-s3"
  group  = aws_iam_group.group-tf-state.name
  policy = data.aws_iam_policy_document.s3-backend.json
}

data "aws_iam_user" "user" {
 user_name = var.user
}

data "aws_iam_policy_document" "s3-backend" {
  statement {
    sid = "1"
    principals {
      type = "AWS"
      identifiers = [
      "${data.aws_caller_identity.current.arn}",
      "${data.aws_iam_user.user.arn}"
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws::s3:::${var.bucket}",
      "arn:aws::s3:::${var.bucket}/*",
    ]
  }
}

resource "aws_iam_group_policy" "policy-tf-state-dynamodb" {
  name   = "${var.env}-${var.app}-policy-tf-state-dynamodb"
  group  = aws_iam_group.group-tf-state.name
  policy = data.aws_iam_policy_document.dynamodb-remote.json
}

data "aws_iam_policy_document" "dynamodb-remote" {
  statement {

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:ListTables",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:TagResource",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable"
    ]

    resources = [
      "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb_table_name}"
    ]
  }
}
