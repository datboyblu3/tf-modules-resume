variable "region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}


variable "email" {
  description = "Email address used for LetsEncrypt registration"
  type        = string
  default     = ""
}

variable "domain" {
  description = "root domain name for registering certificate"
  type        = string
  default     = ""
}

variable "sub_domain_1" {
  description = "subdomain 1"
  type        = string
  default     = ""
}

variable "sub_domain_2" {
  description = "subdomain 2"
  type        = string
  default     = ""
}

#variable "lb_name" {
# description = "name of load balancer"
# type= string
# default = ""
#}

#variable "az_zone" {
# description = "default availability zone for loadbalancer"
# type = string
# default = "us-east-1a"
#}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(any)
  default = {
    project     = "Blog"
    environment = "dev"
    Name        = "server-alb"
  }
}
