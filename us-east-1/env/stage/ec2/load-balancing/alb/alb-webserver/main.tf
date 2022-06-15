locals {
  name                        = "alb-webservers-prd"
  environment                 = "prd"
  internal                    = false
  load_balancer_type          = "application"
  security_groups             = ["sg-lb"]
  subnets                     = ["10.10.0.0/22"]
  enable_deletion_protection  = true
  logs_bucket_s3              = "s3-logs-alb-webservers-prd"
  logs_prefix                 = "alb-"
  logs_enabled                = true
  owner                       = "sreteam"
}

resource "aws_lb" "alb" {
  name                        = local.name
  internal                    = local.internal
  load_balancer_type          = local.load_balancer_type
  security_groups             = local.security_groups
  subnets                     = local.subnets
  enable_deletion_protection  = local.enable_deletion_protection

  access_logs {
    bucket  = local.logs_bucket_s3
    prefix  = local.logs_prefix
    enabled = local.logs_enabled
  }

  tags = {
    Name        = local.name
    Environment = local.environment
    Manageby    = "Terraform"
    Owner       = local.owner
    Terraform   = true
  }
}