output "id" {
  value = aws_vpc.terraform-vpc.id
}

output "subnet_ids" {
  value = aws_subnet.terraform-subnets.*.id
}

output "availability_zones" {
  value = aws_subnet.terraform-subnets.*.availability_zone
}
