## Modules
module "aws_vpc" {
  source = "./modules/aws-vpc"

  cidr_block = var.cidr_block
  project_name = var.project_name
}
