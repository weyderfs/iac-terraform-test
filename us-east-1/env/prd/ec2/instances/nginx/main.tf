locals {
  ami                     = "ami-00bf5f1c358708486" #AMZ Linux 2
  environment             = "prd"
  instance_type           = "t2.micro"
  key_name                = "sre_key"
  monitoring              = false
  name                    = "ec2-nginx"
  owner                   = "sre-team"
  subnet_id               = ""
  user_data               = "use_data.sh"
  vpc_security_group_ids  = [""]

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
    Manageby    = "Terraform"
    Owner       = local.owner
    Terraform   = true
  }
}