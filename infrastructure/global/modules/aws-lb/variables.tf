variable "project_name" {
  type = string
  description = "Project name"
}

variable "vpc" {
  type = object({
    vpc_id     = string
    subnet_ids = list(string)
  })

  description = "VPC information"
}

variable "instance_ids" {
  type = list(string)
}
