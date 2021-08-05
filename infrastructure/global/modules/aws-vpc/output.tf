output "id" {
  value = aws_vpc.terraform-vpc.id
}

output "subnet_ids" {
  value = [for sub_net in aws_subnet.terraform-subnets : sub_net.id]
}

output "availability_zones" {
  value = [for sub_net in aws_subnet.terraform-subnets : sub_net.availability_zone]
}
