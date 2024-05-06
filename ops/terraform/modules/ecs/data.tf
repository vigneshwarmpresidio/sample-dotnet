data "aws_region" "current" {}

data "aws_iam_role" "iam_arn" {
  count = var.create_iam_ecs_role ? 0 : 1
  name  = var.iam_name_ecs
}
