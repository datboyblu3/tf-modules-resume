# Terraform Modules

This is my personal repo for hand built Terraform modules. Feel free to fork or clone!

**NOTE: These are WIP and are very rigid. They need refinement**

# AWS provider example w/ default tags:

```
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Purpose   = "Personal Blog"
      ManagedBy = "Terraform"
    }
  }
}


```

# Remote state file example `.tfbackend` :

```


bucket         = "<BUCKET_NAME>" #substitute r0land.link for app and dev for environment
region         = "<AWS_REGION>"
dynamodb_table = "<TABLE_NAME"
encrypt        = true

```
