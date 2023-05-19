output "origin_id" {
  description = "id of origin_access_identity"
  value       = aws_cloudfront_origin_access_identity.s3_distro.id
}
