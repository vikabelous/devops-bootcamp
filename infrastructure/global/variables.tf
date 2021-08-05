variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "project_name" {
  type = string
  default = "terraform-kittens-store"
}

data "aws_availability_zones" "available" {
  state = "available"
  exclude_names = ["us-west-2d"]
}

locals {
  availability_zones = sort(data.aws_availability_zones.available.names)
}
