resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = format("service/%s/%s", module.ecs.cluster_name, aws_ecs_service.this.name)
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_up" {
  name               = "ecs-service-scale-up"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 120
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "scale_down" {
  name               = "ecs-service-scale-down"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name          = "ecs-high-cpu-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = 60

  dimensions = {
    ClusterName = module.ecs.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [aws_appautoscaling_policy.scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  alarm_name          = "ecs-low-cpu-utilization"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = 25

  dimensions = {
    ClusterName = module.ecs.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [aws_appautoscaling_policy.scale_down.arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_utilization_high" {
  alarm_name          = "ecs-high-memory-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = 60

  dimensions = {
    ClusterName = module.ecs.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [aws_appautoscaling_policy.scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_utilization_low" {
  alarm_name          = "ecs-low-memory-utilization"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = 10

  dimensions = {
    ClusterName = module.ecs.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [aws_appautoscaling_policy.scale_down.arn]
}
