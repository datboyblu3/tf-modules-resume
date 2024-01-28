#creates ssh key pair for ec2 access via ssh w/ local ssh key
resource "aws_key_pair" "r0land_ssh_key" {
  key_name   = var.key_name
  public_key = file("~/.ssh/dev.pub")
}

data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = false
}


resource "aws_route53_record" "blog" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "blog.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.r0land_eip.public_ip]
}


#reserves a AWS Elastic IP
resource "aws_eip" "r0land_eip" {
  vpc = true
}

#Associates Elastic IP to ec2 instance
resource "aws_eip_association" "r0land_eip_assoc" {
  instance_id   = aws_instance.r0land_instance.id
  allocation_id = aws_eip.r0land_eip.allocation_id
}

#creates ec2 instance
resource "aws_instance" "r0land_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.r0land_sg.id]
  user_data                   = file("${path.module}/install.sh")
  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    encrypted             = true
    delete_on_termination = true
  }
  tags = var.resource_tags
}

#create security group for ssh,http,https access
resource "aws_security_group" "r0land_sg" {
  name        = var.sg_name
  description = var.sg_description
  tags        = var.resource_tags
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

data "external" "whatismyip" {
  program = ["/bin/bash", "${path.module}/whatismyip.sh"]
}

#security group rules seperated out to allow for modifications
resource "aws_security_group_rule" "allow_ssh_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.r0land_sg.id
  description       = var.sg_description
  from_port         = local.ssh_port
  to_port           = local.ssh_port
  protocol          = local.tcp_protocol
  cidr_blocks       = [format("%s/%s", data.external.whatismyip.result["internet_ip"], 32)]
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.r0land_sg.id
  description       = var.sg_description

  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_https_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.r0land_sg.id
  description       = var.sg_description

  from_port   = local.https_port
  to_port     = local.https_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.r0land_sg.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips

}

