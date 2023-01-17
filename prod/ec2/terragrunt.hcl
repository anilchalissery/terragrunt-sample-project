locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=4.3.0"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs = {
        public_subnets = ["subnet-eddcdzz4"]
    }
}


inputs = {
  name = "${local.common_vars.locals.prjname}-${local.common_vars.locals.env}-media"

  ami                    = "${local.common_vars.locals.ami}"
  instance_type          = "${local.common_vars.locals.instance_type}"
  key_name               = "${local.common_vars.locals.key_name}"
  monitoring             = "${local.common_vars.locals.monitoring}"
  subnet_id              = "${dependency.vpc.outputs.public_subnets[0]}"

  tags = {
    Environment = "${local.common_vars.locals.env}"
  }
}
