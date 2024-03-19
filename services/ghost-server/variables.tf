# variable "resource_tags" {
#   description = "Tags to set for all resources"
#   type        = map(any)
#   default = {
#     project     = "Blog"
#     environment = "dev"
#     Name        = "server"
#   }
# }

variable "env" {
  description = "code/app environement"
  type        = string
  validation {
    condition = anytrue([
      var.env == "dev",
      var.env == "stage",
      var.env == "prod",
      var.env == "testing"
    ])
    error_message = "Please use one of the approved environement names: dev, stage, prod, testing"
  }
}

variable "app" {
  description = "app or project name"
  type        = string
  default     = ""
  validation {
    condition     = length(var.app) > 4
    error_message = "app name must be at least 4 characters"
  }
}

variable "username" {
  description = "username of the ec2 instance"
  type        = string
}

variable "domain" {
  description = "domain name from cloudflare hosted zone"
  type        = string
  default     = ""
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
