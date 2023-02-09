output "all_users" {
  value       = aws_iam_user.example
  description = "The ARN of the created user"
}

output "all_arns" {
  value = values(aws_iam_user.example[*].arn)
}
