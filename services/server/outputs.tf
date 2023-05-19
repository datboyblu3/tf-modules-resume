output "id" {
  description = "The ID of the instance"
  value       = aws_instance.r0land_instance.id
}

output "new_public_ip" {
  description = "public ip from Elastic IP allocation"
  value       = aws_eip.r0land_eip.public_ip
}
