variable "project_name" {
  type = string
  description = "Project name"
}

variable "ami_id" {
  type = string
  description = "EC2 AMI ID"
}

variable "vpc_id" {
  type = string
  description = "VPC ID for EC2"
}

variable "subnet_id" {
  type = string
  description = "Subnet ID for EC2"
}

variable "ssh_cidr_block" {
  type = string
  description = "Allow SSH access to the EC2 from this ip"
}

variable "assigned_security_groups" {
  type = list(string)
  description = "Security groups for instance"
  default = []
}

variable "user_data" {
  type = string
  description = "User data to provide when launching the instance"
}

variable "ssh_key_pub" {
  type = string
  description = "Publish SSH key for SSH access to EC2"
}
