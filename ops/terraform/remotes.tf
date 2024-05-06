data "terraform_remote_state" "tfcloud_outputs" {
  backend = "remote"
  config = {
    hostname     = "app.terraform.io"
    organization = "Sorenson"
    workspaces = {
      name = local.deployment.outputs_workspace
    }
  }
}

locals {
  # The following variables are used to retrieve the remote outputs from the TFCloud Outputs workspace. This is how the
  # remote outputs should be referenced within this deployment instead of using the tfcloud_outputs data source directly.
  remote_resources = {
    vpc_id             = data.terraform_remote_state.tfcloud_outputs.outputs.vpc_id
    public_subnet_ids  = data.terraform_remote_state.tfcloud_outputs.outputs.public_subnet_ids
    private_subnet_ids = data.terraform_remote_state.tfcloud_outputs.outputs.private_subnet_ids
  }
}
