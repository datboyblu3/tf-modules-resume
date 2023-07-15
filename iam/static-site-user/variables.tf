variable "user" {
  description = "name of IAM user"
  type        = string
  default     = "stage"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

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
  description = "app name"
  type        = string
  default     = ""
  validation {
    condition     = length(var.app) > 4
    error_message = "app name must be at least 4 characters"
  }
}

variable "bucket" {
  description = "name of remote state bucket"
  type        = string
  default     = ""
}
