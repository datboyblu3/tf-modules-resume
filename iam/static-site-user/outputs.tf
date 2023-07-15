output "user_name" {
  description = "IAM user name"
  value       = aws_iam_user.app-deploy.name
}

output "arn" {
  description = "arn of IAM user"
  value       = aws_iam_user.app-deploy.arn
}

output "secret" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_access_key.app-prod-key.secret
  sensitive   = true
}

output "access_key_id" {
  value = aws_iam_access_key.app-prod-key.id
}
