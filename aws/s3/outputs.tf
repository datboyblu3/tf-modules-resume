output "bucket_name" {
  description = "bucket_name"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "bucket_region" {
  description = "bucket region"
  value       = aws_s3_bucket.this.region
}

output "website_endpoint" {
  description = "aws s3 website bucket endpoint"
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}

output "website_domain" {
  description = "aws s3 website domain"
  value       = aws_s3_bucket_website_configuration.this.website_domain
}
