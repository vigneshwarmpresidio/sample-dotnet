module "ecs_log_group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "3.3.0"

  name              = "/aws/ecs/${local.service_name_with_env}"
  retention_in_days = var.log_group_retention
}
