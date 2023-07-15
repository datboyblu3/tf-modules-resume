variable "env" {
  description = "code/app environement"
  type = string
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
  type = string
  default = ""
  validation {
    condition = length(var.app) > 4
    error_message = "app name must be at least 4 characters"
  }
}

variable "region" {
  description = "AWS REGION"
  type        = string
  default     = "us-east-1"
}

variable "bucket" {
  description = "bucket name"
  type        = string
  default     = ""
}

variable "dynamodb_table_name" {
  description = "Name of the dynamodb table"
  type        = string
  default     = "tf-locks"
}


