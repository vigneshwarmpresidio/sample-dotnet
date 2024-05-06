locals {
  # Environment-specific service name. Note that the service name is not appended with the environment name for production
  service_name_with_env = startswith(var.environment, "prod") ? var.service_name : "${var.service_name}-${var.environment}"
}
