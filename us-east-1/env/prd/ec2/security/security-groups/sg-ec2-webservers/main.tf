locals {
  name                  = "tf-sg-webservers"
  sg_description        = "SG usado pelas EC2 de Webserver"
  environment           = "prd"
  vpc_id                = "vpc-b156efd6" #fake
  ingress_description   = "Allow SSH"
  ingres_from_port      = 22
  ingres_to_port        = 22
  ingres_protocol       = "tcp"
  ingres_cidr_blocks    = ["0.0.0.0/0"]
  egress_from_port      = 0
  egress_to_port        = 0
  egress_protocol       = "-1"
  egress_cidr_blocks    = ["0.0.0.0/0"]
  owner                 = "sreteam"

}

resource "aws_security_group" "sg" {
  name        = "${local.name}-${local.environment}"
  description = local.sg_description
  vpc_id      = local.vpc_id

  ingress {
    description   = local.ingress_description
    from_port     = local.ingres_from_port
    to_port       = local.ingres_to_port
    protocol      = local.ingres_protocol
    cidr_blocks   = local.ingres_cidr_blocks
  }

  egress {
    from_port     = local.egress_from_port
    to_port       = local.egress_to_port
    protocol      = local.egress_protocol
    cidr_blocks   = local.egress_cidr_blocks
  }

  tags = {
    Name        = "${local.name}-${local.environment}"
    Environment = local.environment
    Manageby    = "Terraform"
    Owner       = local.owner
    Terraform   = true
  }
}