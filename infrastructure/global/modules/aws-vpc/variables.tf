variable "cidr_block" {
  type    = string
}

variable "project_name" {
  type    = string
}

variable "availability_zones" {
  type = list(string)
}
