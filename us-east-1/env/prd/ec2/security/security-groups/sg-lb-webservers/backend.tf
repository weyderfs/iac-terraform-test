terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63.0"
      region  = "us-east-1"
      profile = "default"
    }
  }
    # backend "s3" {
    #   bucket      = "iac-terraform-states"
    #   region      = "us-east-1"
    #   profile     = "default"
    #   encrypt     = true
    #   kms_key_id  = "aws/s3"
    #   key         = "aws/us-east-1/env/prd/ec2/security/security-groups/sg-lb-webservers-prd/terraform.tfstate"
    # }
}

provider "aws" {
  region = "us-east-1"
}
