resource "aws_ecs_task_definition" "this" {
  family                   = local.service_name_with_env
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  execution_role_arn       = var.create_iam_ecs_role ? aws_iam_role.ecs_tasks_execution_role[0].arn : data.aws_iam_role.iam_arn[0].arn
  task_role_arn            = var.create_iam_ecs_role ? aws_iam_role.ecs_tasks_execution_role[0].arn : data.aws_iam_role.iam_arn[0].arn
  skip_destroy             = true

  container_definitions = jsonencode([
    {
      name   = local.service_name_with_env
      image  = var.image_name != "" ? var.image_name : "ppowersn/always-healthy:latest"
      cpu    = var.task_definition_cpu
      memory = var.task_definition_memory
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = 8080
          hostPort      = 8080
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = module.ecs_log_group.cloudwatch_log_group_name,
          awslogs-region        = data.aws_region.current.name,
          awslogs-stream-prefix = "ecs"
        }
      }
      environment = [
        {
          name  = "AWS_REGION"
          value = var.region
        },
        {
          name  = "ENVIRONMENT"
          value = var.environment
        },
        {
          name  = "ASPNETCORE_ENVIRONMENT"
          value = var.environment
        }
      ]
    }
  ])

  depends_on = [var.ecs_task_depends_on]
}
