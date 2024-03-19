#creates ssh key pair for ec2 access via ssh w/ local ssh key
resource "aws_key_pair" "vps_ssh_key" {
  key_name   = "${var.env}-${var.app}-ssh"
  public_key = trimspace(tls_private_key.ssh-ed25519.public_key_openssh)
}

resource "tls_private_key" "ssh-ed25519" {
  algorithm = "ED25519"
}

#reserves a AWS Elastic IP
resource "aws_eip" "elastic_ip" {
}

#Associates Elastic IP to ec2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ghost_server.id
  allocation_id = aws_eip.elastic_ip.allocation_id
}

#creates ec2 instance
resource "aws_instance" "ghost_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.vps_ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = data.cloudinit_config.test.rendered
  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    encrypted             = true
    delete_on_termination = true
  }
  metadata_options {
    http_tokens = "required"
  }
  #tags = var.resource_tags
}

#create security group for ssh,http,https access
resource "aws_security_group" "web_sg" {
  name        = "${var.env}-${var.app}-sg"
  description = "permits ssh, http & TLS traffic"
  #tags        = var.resource_tags
}

#sets local variables for security group rules
locals {
  http_port    = 80
  https_port   = 443
  ssh_port     = 22
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}


#security group rules seperated out to allow for modifications
resource "aws_security_group_rule" "allow_ssh_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web_sg.id
  description       = "ssh inbound"
  from_port         = local.ssh_port
  to_port           = local.ssh_port
  protocol          = local.tcp_protocol
  cidr_blocks       = [format("%s/%s", data.external.whatismyip.result["internet_ip"], 32)]
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web_sg.id
  description       = "http inbound"

  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_https_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web_sg.id
  description       = "https inbound"

  from_port   = local.https_port
  to_port     = local.https_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.web_sg.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips

}

