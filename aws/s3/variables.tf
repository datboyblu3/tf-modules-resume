variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "resource_tags" {
  description = "Tags to set for specified resources"
  type        = map(any)
  default = {
    Project     = "app"
    Environment = "dev"
    Name        = "Application"
  }

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

variable "type" {
  description = "type of bucket i.e terraform state, website, logging"
  type        = string
  default     = "resource"
}


variable "is_destroy" {
  description = "force destroy of bucket"
  type        = bool
  default     = "false"
}


variable "enable_web" {
  description = "enable bucket website configuration"
  type        = bool
  default     = false
}

variable "public" {
  description = "enable public access on bucket"
  type        = bool
  default     = true
}

