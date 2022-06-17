output "name" {
  value       = aws_lb.alb.name
  description = "Output do nome do SG"
}

output "load_balancer_type" {
  value       = aws_lb.alb.load_balancer_type
  description = "Tipo do LB"
}