locals {
  ami                     = "ami-0022f774911c1d690"
  environment             = "stage"
  instance_type           = "t2.micro"
  key_name                = "sre_key"
  monitoring              = false
  name                    = "ec2-nginx-stage"
  owner                   = "sre-team"
  subnet_id               = ""
  vpc_security_group_ids  = 

}

module "ec2" {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-ec2-instance.git?ref=v4.0.0"

  name                    = local.name
  ami                     = local.ami
  instance_type           = local.instance_type
  key_name                = local.key_name
  monitoring              = local.monitoring
  vpc_security_group_ids  = local.vpc_security_group_ids
  subnet_id               = local.subnet_id

  tags = {
    Name        = local.name
    Environment = local.environment
    Manageby    = "Terraform"
    Owner       = local.owner
    Terraform   = true
  }
}