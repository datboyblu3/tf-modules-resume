#############################acm############################
resource "aws_iam_group" "group-acm" {
  name = "${var.env}-${var.app}-group-acm"
  path = "/${var.env}-${var.app}-acm/"
}

resource "aws_iam_group_policy" "prod-policy-acm" {
  name   = "${var.env}-${var.app}-policy-acm"
  group  = aws_iam_group.group-acm.name
  policy = data.aws_iam_policy_document.acm.json
}

data "aws_iam_policy_document" "acm" {
  statement {
    actions = [
      "acm:AddTagsToCertificate",
      "acm:RequestCertificate",
      "acm:DeleteCertificate",
      "acm:DescribeCertificate",
      "acm:GetAccountConfiguration",
      "acm:GetCertificate",
      "acm:ImportCertificate",
      "acm:ListCertificates",
      "acm:ListTagsForCertificate",
      "acm:PutAccountConfiguration",
      "acm:RemoveTagsFromCertificate",
      "acm:RenewCertificate",
      "acm:UpdateCertificateOptions"

    ]

    resources = [
      "*"
    ]
  }
}
