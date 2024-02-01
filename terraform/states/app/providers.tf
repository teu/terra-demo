terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.34"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"

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

data "aws_ecr_authorization_token" "token" {
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
  registry_auth {
    address  = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}
