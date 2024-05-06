variable "deployment_id" {
  description = "The deployment identifier (eg: sli-dev-usea1)"
  type        = string
}

variable "service_image_name" {
  description = "The full Docker image name that the ECS service will use"
  type        = string
  default     = "ppowersn/always-healthy:latest"
}
