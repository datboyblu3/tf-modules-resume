variable "bucket" {
  description = "bucket name for hosting static files"
  type        = string
  default     = ""
}

variable "website" {
  description = "bucket name for hosting static files"
  type        = string
  default     = ""
}

variable "cert_arn" {
  description = "ACM Certificate ARN"
  type = string
  default = ""
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(any)
  default = {
    project     = "Blog"
    environment = "r0land-link.com"
    Name        = "Static Site"
  }
}
