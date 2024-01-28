output "user_name" {
  description = "IAM user name"
  value       = aws_iam_user.user.name
}

output "arn" {
  description = "arn of IAM user"
  value       = aws_iam_user.user.arn
}

output "path" {
  description = "IAM user path"
  value       = aws_iam_user.user.path
}

output "secret" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_access_key.ssh-access.secret
  sensitive   = true
}

output "access_key_id" {
  value = aws_iam_access_key.ssh-access.id
}
