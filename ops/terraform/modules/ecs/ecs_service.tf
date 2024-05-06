resource "aws_ecs_service" "this" {
  name                  = local.service_name_with_env
  cluster               = module.ecs.cluster_id
  task_definition       = aws_ecs_task_definition.this.arn
  wait_for_steady_state = true

  desired_count = var.desired_count

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  # launch_type                        = "FARGATE"
  force_new_deployment = true

  dynamic "capacity_provider_strategy" {
    for_each = var.capacity_provider_strategy
    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      base              = capacity_provider_strategy.value.base
      weight            = capacity_provider_strategy.value.weight
    }
  }

  network_configuration {
    subnets          = var.ecs_service_subnet_ids
    security_groups  = [var.security_groups_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = local.service_name_with_env
    container_port   = 8080
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}
