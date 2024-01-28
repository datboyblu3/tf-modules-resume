#Simple AWS S3 terraform module

I decided to move away from tfvars in an effort to reduce code duplication.


```
terraform {
  backend "s3" {
    bucket         = ""
    region         = ""
    dynamodb_table = ""
    encrypt        = true
    key            = ""
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "s3" {
  source = "https://github.com/alexrf45/tf-modules-resume//aws/s3"
  env    = ""
  app    = ""
  resource_tags = {Project = "demo", Application = "demo-app", Environment = "dev"}
  enable_bucket_versioning = false
  type = "bucket"
  is_destroy = true
  enable_web = true
  public = false
}


#outputs

output "bucket_name" {
  description = "bucket_name"
  value = module.s3.bucket_name
}

output "bucket_arn" {
  description = "bucket ARN"
  value = module.s3.bucket_arn
}

output "bucket_region" {
  description = "bucket region"
  value = module.s3.bucket_region
}

output "website_endpoint" {
  description = "aws s3 website bucket endpoint"
  value = module.s3.website_endpoint
}

output "website_domain" {
  description = "aws s3 website domain"
  value = module.s3.website_domain
}
```
