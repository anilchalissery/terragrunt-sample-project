locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "tfr:///anilchalissery/s3bucket/aws?version=0.0.1"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  name = "${local.common_vars.locals.prjname}-${local.common_vars.locals.env}-media"
}
