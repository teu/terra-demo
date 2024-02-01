terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.34"
    }
  }

  backend "s3" {
    key    = "network"
    region = var.terraform_state_bucket_region
  }
}

provider "aws" {
  region      = var.aws_region
  max_retries = var.max_retries

  default_tags {
    tags = var.default_aws_tags
  }
}
