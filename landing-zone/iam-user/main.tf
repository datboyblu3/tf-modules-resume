resource "aws_iam_user" "example" {
  for_each = var.user_name
  name = each.value
}


