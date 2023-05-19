output "cert_url" {
  description = "Full URL of cert"
  value       = acme_certificate.certificate.certificate_url
}

output "certificate_expiration_date" {
  description = "expiration date of cert"
  value       = acme_certificate.certificate.certificate_not_after
}

output "public_ip" {
  description = "public ip from Elastic IP allocation"
  value       = aws_eip.r0land-link.public_ip
}


