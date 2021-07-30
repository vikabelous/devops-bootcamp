variable "project_name" {
  type = string
}

variable "vpc" {
  type = object({
    vpc_id     = string
    subnet_ids = list(string)
  })

  description = "VPC information"
}
