variable "project_name" {
  type = string
  description = "Project name"
}

variable "lb_tg_arn" {
  type = string
}

variable "vpc" {
  type = object({
    vpc_id     = string
    subnet_ids = list(string)
  })

  description = "VPC information"
}

variable "aws_launch_template_name" {
  type = string
}
