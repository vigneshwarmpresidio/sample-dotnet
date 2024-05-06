module "ecs_service" {
  source = "./modules/ecs"

  cluster_name  = "${local.deployment.product}-${local.deployment.environment}"
  service_name  = local.deployment.component_name
  desired_count = local.deployment.service_desired_count
  min_capacity  = local.deployment.service_min_capacity
  max_capacity  = local.deployment.service_max_capacity

  create_iam_ecs_role    = true
  environment            = local.deployment.environment
  region                 = local.deployment.aws_region
  ecs_service_subnet_ids = local.remote_resources.private_subnet_ids
  iam_name_ecs           = join("-", [local.deployment.product, "service", "ecs-task-execution-role", local.deployment.environment, local.deployment.aws_region])
  security_groups_id     = module.ecs-service-security-group.security_group_id
  target_group_arn       = module.alb.target_group_arns[0]
  task_definition_cpu    = 512
  task_definition_memory = 1024

  image_name = var.service_image_name
}

resource "aws_route53_record" "example" {
  name    = "${local.deployment.component_name}-${local.deployment.environment}"
  zone_id = data.aws_route53_zone.public.zone_id
  type    = "A"

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}
