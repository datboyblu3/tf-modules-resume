variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    project     = "vps server"
    environment = "dev"
    Name        = "vps"
  }
}

variable "ami" {
  description = "Amazon Machine Image"
  type        = string

}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t3a.medium"
}

variable "volume_size" {
  description = "Size of Volume"
  type        = string
  default     = "30"

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


variable "username" {
  description = "username for vps instance"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Name of the associated ec2 key pair"
  type        = string
  default     = "vps"
}


variable "sg_name" {
  description = "Name of security group"
  type        = string
  default     = "vps_sg"
}


variable "sg_description" {
  description = "Description of security group"
  type        = string
  default     = "SSH & HTTP/HTTPS"
}

