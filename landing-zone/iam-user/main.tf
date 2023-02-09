resource "aws_iam_user" "example" {
  for_each = toset(var.user_name)
  name = each.value
}


