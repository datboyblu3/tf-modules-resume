data "template_file" "userdata" {
  template = file("${path.module}/templates/userdata.yaml")

  vars = {
    username       = var.username
    ssh_public_key = tls_private_key.ssh-ed25519.public_key_openssh
    packages       = jsonencode(var.packages)
  }
}
