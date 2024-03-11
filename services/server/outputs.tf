output "id" {
  description = "The ID of the instance"
  value       = aws_instance.web_instance.id
}

output "new_public_ip" {
  description = "public ip from Elastic IP allocation"
  value       = aws_eip.elastic_ip.public_ip
}

output "private-key" {
  value = tls_private_key.ssh-ed25519.private_key_openssh
}

