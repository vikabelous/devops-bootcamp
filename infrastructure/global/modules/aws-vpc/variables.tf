variable "cidr_block" {
  type    = string
}

variable "project_name" {
  type    = string
}

variable "subnets_number" {
  type    = number
  default = 2
}

data "aws_availability_zones" "available" {
  state = "available"
}
