module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "4.1.1"

  # TODO: The cluster should be created outside of this application and there should only be one cluster in each account
  # for each team/product (eg: a cluster named 'account-services-gm'). The individual services should then be created using
  # environment-specific names (eg: 'account-services-web-server-dev', 'account-services-web-server-qa', etc).

  cluster_name = var.cluster_name

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 10
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 90
      }
    }
  }
}
