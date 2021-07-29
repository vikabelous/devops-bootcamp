output "ec2_public_ip" {
  value = aws_instance.terraform-instance.public_ip
}
