# Instructions
## Before you start working with Terraform

Please install [pre-commit](https://pre-commit.com/#install)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm_alb"></a> [acm\_alb](#module\_acm\_alb) | ./modules/acm | n/a |
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | 8.7.0 |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ./modules/ecr | n/a |
| <a name="module_ecs-service-security-group"></a> [ecs-service-security-group](#module\_ecs-service-security-group) | terraform-aws-modules/security-group/aws | 4.13.0 |
| <a name="module_ecs_service"></a> [ecs\_service](#module\_ecs\_service) | ./modules/ecs | n/a |
| <a name="module_public-http-https-security-group"></a> [public-http-https-security-group](#module\_public-http-https-security-group) | terraform-aws-modules/security-group/aws | 4.13.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [terraform_remote_state.tfcloud_outputs](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_id"></a> [deployment\_id](#input\_deployment\_id) | The deployment identifier (eg: sli-dev-usea1) | `string` | n/a | yes |
| <a name="input_service_image_name"></a> [service\_image\_name](#input\_service\_image\_name) | The full Docker image name that the ECS service will use | `string` | `"ppowersn/always-healthy:latest"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
