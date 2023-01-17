locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=3.5.0"
}

include "root" {
  path = find_in_parent_folders()
}



inputs = {
  name = "${local.common_vars.locals.prjname}-${local.common_vars.locals.env}"
  cidr = local.common_vars.locals.cidr

  azs             = local.common_vars.locals.azs
  private_subnets = local.common_vars.locals.private_subnets
  public_subnets  = local.common_vars.locals.public_subnets

  enable_nat_gateway = local.common_vars.locals.enable_nat_gateway
  enable_vpn_gateway = local.common_vars.locals.enable_vpn_gateway

  tags = {
    Environment = local.common_vars.locals.env
  }
}
