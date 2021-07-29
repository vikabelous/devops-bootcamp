output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = module.aws_vpc.id
}

output "subnet_ids" {
  value = module.aws_vpc.subnet_ids
}

output "availability_zones" {
  value = module.aws_vpc.availability_zones
}
