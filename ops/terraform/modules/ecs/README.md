<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs"></a> [ecs](#module\_ecs) | terraform-aws-modules/ecs/aws | 4.1.1 |
| <a name="module_ecs_log_group"></a> [ecs\_log\_group](#module\_ecs\_log\_group) | terraform-aws-modules/cloudwatch/aws//modules/log-group | 3.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_metric_alarm.cpu_utilization_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_utilization_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.memory_utilization_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.memory_utilization_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_tasks_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_tasks_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.ecs_tasks_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.iam_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the ECS cluster. | `string` | n/a | yes |
| <a name="input_create_iam_ecs_role"></a> [create\_iam\_ecs\_role](#input\_create\_iam\_ecs\_role) | n/a | `bool` | n/a | yes |
| <a name="input_ecs_service_subnet_ids"></a> [ecs\_service\_subnet\_ids](#input\_ecs\_service\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_iam_name_ecs"></a> [iam\_name\_ecs](#input\_iam\_name\_ecs) | n/a | `string` | n/a | yes |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_security_groups_id"></a> [security\_groups\_id](#input\_security\_groups\_id) | n/a | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service. This should NOT contain the environment name. | `string` | n/a | yes |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | n/a | `string` | n/a | yes |
| <a name="input_task_definition_cpu"></a> [task\_definition\_cpu](#input\_task\_definition\_cpu) | n/a | `number` | n/a | yes |
| <a name="input_task_definition_memory"></a> [task\_definition\_memory](#input\_task\_definition\_memory) | n/a | `number` | n/a | yes |
| <a name="input_capacity_provider_strategy"></a> [capacity\_provider\_strategy](#input\_capacity\_provider\_strategy) | The list capacity providers strategy to use for the service | <pre>list(object({<br>    capacity_provider = string<br>    base              = number<br>    weight            = number<br>  }))</pre> | <pre>[<br>  {<br>    "base": 1,<br>    "capacity_provider": "FARGATE",<br>    "weight": 10<br>  },<br>  {<br>    "base": 0,<br>    "capacity_provider": "FARGATE_SPOT",<br>    "weight": 90<br>  }<br>]</pre> | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| <a name="input_ecs_task_depends_on"></a> [ecs\_task\_depends\_on](#input\_ecs\_task\_depends\_on) | Variable to set additional dependencies for ECS task definition (ElastiCache Redis and so on) | `any` | `[]` | no |
| <a name="input_log_group_retention"></a> [log\_group\_retention](#input\_log\_group\_retention) | n/a | `number` | `7` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | Maximum number of tasks should the service scale to | `number` | `1` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | Minimum number of tasks should the service always maintain | `number` | `1` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
