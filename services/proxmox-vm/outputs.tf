output "private-key" {
  description = "private key for logging in via ssh"
  value       = tls_private_key.ssh-ed25519.private_key_openssh
  sensitive   = true
}
