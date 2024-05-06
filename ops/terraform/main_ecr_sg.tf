# 1
module "ecr" {
  source = "./modules/ecr"

  ecr_name = local.deployment.component_name
}

# 2 Create SG
module "public-http-https-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"

  name        = "public-http-https-sg"
  description = "public-http-https-sg"
  vpc_id      = local.remote_resources.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]

  egress_rules = ["all-all"]
}

module "ecs-service-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"

  name        = "ecs-service-sg"
  description = "ecs-service-sg"
  vpc_id      = local.remote_resources.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-8080-tcp"
      source_security_group_id = module.public-http-https-security-group.security_group_id
    }
  ]

  egress_rules = ["all-all"]
}
