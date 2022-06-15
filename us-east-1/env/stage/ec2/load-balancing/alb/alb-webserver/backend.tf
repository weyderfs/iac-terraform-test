terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63.0"
      region  = "us-east-1"
      profile = "default"
    }
    # backend "s3" {
    #   bucket      = "iac-states"
    #   region      = "us-east-1"
    #   profile     = "default"
    #   encrypt     = true
    #   kms_key_id  = "aws/s3"
    #   key         = "aws/us-east-1/env/stage/ec2/load-balancing/alb/alb-webserver/terraform.tfstate"
    # }
  }
}
provider "aws" {
  region = "us-east-1"
}