<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.sorensoncloud](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.sorensoncloud](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.certificate_validation_web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_alternative_names"></a> [certificate\_alternative\_names](#input\_certificate\_alternative\_names) | n/a | `list(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | The ARN of the certificate |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
