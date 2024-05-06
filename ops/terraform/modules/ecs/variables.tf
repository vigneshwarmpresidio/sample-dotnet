variable "cluster_name" {
  type        = string
  description = "The name of the ECS cluster."
}
variable "service_name" {
  type        = string
  description = "The name of the service. This should NOT contain the environment name."
}

variable "environment" {
  type = string
}

variable "ecs_service_subnet_ids" {
  type = list(string)
}

variable "security_groups_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "create_iam_ecs_role" {
  type = bool
}

variable "region" {
  type = string
}

variable "iam_name_ecs" {
  type = string
}

variable "image_name" {
  type = string
}

variable "task_definition_cpu" {
  type = number
}

variable "task_definition_memory" {
  type = number
}

variable "log_group_retention" {
  type    = number
  default = 7
}

variable "desired_count" {
  type        = number
  default     = 1
  description = "The number of instances of the task definition to place and keep running"
  nullable    = false
}

variable "max_capacity" {
  type        = number
  default     = 1
  description = "Maximum number of tasks should the service scale to"
  nullable    = false
}

variable "min_capacity" {
  type        = number
  default     = 1
  description = "Minimum number of tasks should the service always maintain"
  nullable    = false
}

variable "capacity_provider_strategy" {
  type = list(object({
    capacity_provider = string
    base              = number
    weight            = number
  }))
  default = [
    {
      capacity_provider = "FARGATE"
      base              = 1
      weight            = 10
    },
    {
      capacity_provider = "FARGATE_SPOT"
      base              = 0
      weight            = 90
    }
  ]
  description = "The list capacity providers strategy to use for the service"
}

variable "ecs_task_depends_on" {
  type        = any
  default     = []
  description = "Variable to set additional dependencies for ECS task definition (ElastiCache Redis and so on)"
}
