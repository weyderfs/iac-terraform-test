locals {
  alb_name                        = "alb-webservers-prd"
  alb_environment                 = "prd"
  alb_internal                    = false
  alb_load_balancer_type          = "application"
  alb_security_groups             = ["sg-lb"]
  alb_subnets                     = ["10.10.0.0/22"]
  alb_enable_deletion_protection  = true
  logs_bucket_s3                  = "s3-logs-alb-webservers-prd"
  logs_prefix                     = "alb-"
  logs_enabled                    = true
  alb_owner                       = "sreteam"
  tg_name                         = "tg-alb-webservers-prd"
  tg_port                         = 80
  tg_protocol                     = "HTTP"
  tg_vpc_id                       = "vpc-08080" #fake
  listener_port                   = "443"
  listener_protocol               = "HTTPS"
  listener_ssl_policy             = "ELBSecurityPolicy-2016-08"
  listener_certificate_arn        = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
}

resource "aws_lb" "alb" {
  name                        = local.alb_name
  internal                    = local.alb_internal
  load_balancer_type          = local.alb_load_balancer_type
  security_groups             = local.alb_security_groups
  subnets                     = local.alb_subnets
  enable_deletion_protection  = local.alb_enable_deletion_protection

  access_logs {
    bucket  = local.logs_bucket_s3
    prefix  = local.logs_prefix
    enabled = local.logs_enabled
  }

  tags = {
    Name        = local.alb_name
    Environment = local.alb_environment
    Manageby    = "Terraform"
    Owner       = local.alb_owner
    Terraform   = true
  }
}

resource "aws_lb_target_group" "talb" {
  name     = local.tg_name
  port     = local.tg_port
  protocol = local.tg_protocol
  vpc_id   = local.tg_vpc_id
}

resource "aws_lb_listener" "lalb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = local.listener_port
  protocol          = local.listener_protocol
  ssl_policy        = local.listener_ssl_policy
  certificate_arn   = local.listener_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.talb.arn
  }
}
