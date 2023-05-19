variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map
  default = {
    project     = "Blog"
    environment = "dev"
    Name        = "server"
  }
}

variable "domain" {
  description = "domain name from route53 hosted zone"
  type        = string
  default     = "r0land.link."
}


variable "ami" {
  description = "Amazon Machine Image"
  type        = string
  default     = "ami-052efd3df9dad4825"

}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t3a.medium"
}

variable "volume_size" {
  description = "Size of Volume"
  type        = string
  default     = "40"

}

variable "volume_type" {
  description = "Type of volume"
  type        = string
  default     = "gp3"

}

variable "associate_public_ip_address" {
  description = "Whether to associate public IP to EC2 Instance"
  type        = bool
  default     = true
}



variable "key_name" {
  description = "Name of the associated ec2 key pair"
  type        = string
  default     = "dev-ssh"
}


variable "sg_name" {
  description = "Name of security group"
  type        = string
  default     = "dev_sg"
}


variable "sg_description" {
  description = "Description of security group"
  type        = string
  default     = "SSH & HTTP/HTTPS"
}

