variable "project_name" {
  type = string
  description = "Project name"
}

variable "instances_number" {
  type = number
  description = "Number of EC2 to create"
}

variable "aws_launch_template_name" {
  type = string
  description = "Launch template name"
}
