locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  aws_profile = local.account_vars.locals.aws_profile_name
}

terraform {
  extra_arguments "aws_profile" {
    commands = [
      "init",
      "apply",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint"
    ]

    env_vars = {
      AWS_PROFILE = "${local.aws_profile}"
    }
  }
}


remote_state {
  backend = "s3"
  config = {
    bucket         = "sampleprj-terraform-backend"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
    profile        = "${local.aws_profile}"
    
  }
}


# Indicate what region to deploy the resources into
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region                   = "us-west-2"    
  profile                  = "${local.aws_profile}"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}

terraform {
  backend "s3" {
    bucket         = "sampleprj-terraform-backend"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true       
    profile        = "${local.aws_profile}"
    dynamodb_table = "terraform-lock-table"
  }
}
EOF
}
