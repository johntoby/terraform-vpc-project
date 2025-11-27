terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider with a specific profile
provider "aws" {
  region  = "eu-west-1"
  profile = "jtbaba"
}

