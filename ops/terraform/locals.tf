locals {

  deployment_json = jsondecode(file("${path.module}/../deployments.json"))
  deployment      = merge(local.deployment_json["common"], local.deployment_json[var.deployment_id])
}
