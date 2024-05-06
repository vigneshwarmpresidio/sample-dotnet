data "aws_vpc" "vpc" {
  id = local.remote_resources.vpc_id
}

data "aws_route53_zone" "public" {
  name = local.deployment.r53_public_zone_name
}
