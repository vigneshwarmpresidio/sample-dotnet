# TODO: This needs to be moved to a shared TF repository

module "acm_alb" {
  source = "./modules/acm"

  zone_id                       = data.aws_route53_zone.public.zone_id
  domain_name                   = local.deployment.r53_public_zone_name
  certificate_alternative_names = ["*.${local.deployment.r53_public_zone_name}"]
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"

  name               = "${local.deployment.product}-${local.deployment.environment}"
  load_balancer_type = "application"
  vpc_id             = data.aws_vpc.vpc.id
  subnets            = local.remote_resources.public_subnet_ids
  security_groups    = [module.public-http-https-security-group.security_group_id]
  target_groups = [
    {
      name_prefix      = "tpa"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/api/ping"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-299"
      }
      stickiness = {
        enabled = true

        type            = "lb_cookie"
        cookie_duration = 86400 # 1 day
      }
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm_alb.certificate_arn
      target_group_index = 0
    }
  ]

  https_listener_rules = [
    {
      actions : [{
        type               = "forward",
        target_group_index = 0
      }],
      conditions = [{
        path_patterns = ["/*", ]
      }]
    }
  ]
}
