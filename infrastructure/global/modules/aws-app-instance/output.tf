output "ec2_public_ips" {
  value = [for ec2 in aws_instance.terraform-instance : ec2.public_ip]
}

output "ec2_ids" {
  value = [for ec2 in aws_instance.terraform-instance : ec2.id]
}
