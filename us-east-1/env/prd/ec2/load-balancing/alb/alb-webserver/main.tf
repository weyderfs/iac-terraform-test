locals {
  alb_name                        = "alb-webservers-prd"
  alb_environment                 = "prd"
  alb_internal                    = false
  alb_load_balancer_type          = "application"
  alb_security_groups             = ["sg-033207b486c9cbb9d"] #tf-sg-alb-prd
  alb_subnets                     = ["subnet-41a5ca24", "subnet-6ff4d037"]
  alb_enable_deletion_protection  = false
  logs_enabled                    = false
  ec2_tg_nginx_arn                = "i-0267015298d46f43d"
  ec2_tg_httpd_arn                = "i-070a6dc21cefc98fc"
  alb_owner                       = "sreteam"
  tg_name                         = "tg-alb-webservers-prd"
  tg_port                         = 80
  tg_protocol                     = "HTTP"
  tg_vpc_id                       = "vpc-b156efd6" #fake
  listener_http_port              = "80"
  listener_http_protocol          = "HTTP"
  listener_https_port             = "443"
  listener_https_protocol         = "HTTPS"
  listener_ssl_policy             = "ELBSecurityPolicy-2016-08"
  listener_certificate_arn        = ""
}

resource "aws_lb_target_group_attachment" "tgan" {
  target_group_arn = aws_lb_target_group.talb.arn
  target_id        = local.ec2_tg_nginx_arn
  port             = 80
}

resource "aws_lb_target_group_attachment" "tgah" {
  target_group_arn = aws_lb_target_group.talb.arn
  target_id        = local.ec2_tg_httpd_arn
  port             = 80
}

resource "aws_lb" "alb" {
  name                        = local.alb_name
  internal                    = local.alb_internal
  load_balancer_type          = local.alb_load_balancer_type
  security_groups             = local.alb_security_groups
  subnets                     = local.alb_subnets
  enable_deletion_protection  = local.alb_enable_deletion_protection

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

resource "aws_lb_listener" "lalb80" {
  load_balancer_arn = aws_lb.alb.arn
  port              = local.listener_http_port
  protocol          = local.listener_http_protocol

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "lalb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = local.listener_https_port
  protocol          = local.listener_https_protocol
  ssl_policy        = local.listener_ssl_policy
  certificate_arn   = local.listener_certificate_arn

  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.talb.id
  }
}
