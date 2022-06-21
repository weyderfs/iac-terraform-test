locals {
  ami                     = "ami-0cff7528ff583bf9a" #AMZ Linux 2
  environment             = "prd"
  instance_type           = "t2.micro"
  key_name                = "darth-test"
  monitoring              = false
  name                    = "ec2-nginx"
  owner                   = "sre-team"
  subnet_id               = "subnet-6ff4d037"
  user_data               = file("user_data.sh")
  vpc_security_group_ids  = ["sg-0eba4382ee00072c1"] #tf-sg-webservers-prd

}

module "ec2" {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-ec2-instance.git?ref=v3.3.0"

  name                    = "${local.name}-${local.environment}"
  ami                     = local.ami
  instance_type           = local.instance_type
  key_name                = local.key_name
  monitoring              = local.monitoring
  vpc_security_group_ids  = local.vpc_security_group_ids
  subnet_id               = local.subnet_id
  user_data               = local.user_data

  tags = {
    Name        = "${local.name}-${local.environment}"
    Environment = local.environment
    Managedby    = "Terraform"
    Owner       = local.owner
    Terraform   = true
  }
}