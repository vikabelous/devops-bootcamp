terraform {
  # pin terraform version
  required_version = "1.0.2"

  # required providers for our bootcamp with version pinning
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-968919042103"
    key    = "devops_bootcamp/live/terraform_project.tfstate"
    region = "us-west-2"
    profile = "devops_bootcamp"
  }
}

provider "aws" {
  profile = "devops_bootcamp"
  region = "us-west-2"
}
