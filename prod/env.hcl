locals {
  prjname             = "splprj"
  env = "prod"
  region = "us-west-2"  
  cidr = "10.10.0.0/16"
  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = true

  ami                    = "ami-095413544ce52437d"
  instance_type          = "t2.micro"
  key_name               = ""
  monitoring             = true

}