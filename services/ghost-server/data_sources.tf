data "external" "whatismyip" {
  program = ["/bin/bash", "${path.module}/whatismyip.sh"]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-mantic-23.10-amd64-server-*"]
  }
  filter {
    name   = "architecture"
    values = ["x84_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "cloudinit_config" "test" {
  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      #      ssh_authorized_keys = [chomp(file("/tmp/key.pub"))] # this pubkey applies to the default (ec2-user, etc...) user which may or may not be created
      users = [
        #        "default", # when commented, default user (ec2-user, etc...) will not be created
        {
          name                = var.username # new username
          shell               = "/bin/bash"
          sudo                = "ALL=(ALL) NOPASSWD:ALL"
          ssh_authorized_keys = trimspace(tls_private_key.ssh-ed25519.public_key_openssh) #ssh-keygen -t ed25519 -C "vps" -N '' -f ~/.ssh/vps
        }
      ]
    })
  }
  part { #useful for bootstrapping the instance
    filename     = "./install.sh"
    content_type = "text/x-shellscript"
    content      = file("./install.sh")
  }
}

data "cloudflare_zones" "domain" {
  filter { name = var.domain }
}
