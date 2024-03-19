#Ghost Server

- A simple EC2 instance with Cloudflare DNS records running a GHOST CMS instance via docker-compose. 

main.tf example:

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.3"
    }
  }
# I included a remote.tfbackend if you want to maintain a remote state file.
  backend "s3" {

  }
}

provider "cloudinit" {}

provider "cloudflare" {}

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Name      = "Ghost Server"
      Purpose   = "CMS"
      ManagedBy = "fr3d"
    }
  }
}


module "ghost" {
domain = "test.local"
env = "dev"
app = "ghost-cms"
username = "ghost"
instance_type = "t3a.medium"


}


```

TODO:
- Initial apply in dev
- confirm access
- docker-compose.yaml
- secure env

