resource "aws_iam_user" "example" {
  for_each = toset(var.username)
  name = each.value
}


