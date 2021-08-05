output "lb_security_group_id" {
  value = aws_security_group.terraform-lb.id
}

output "lb_dns" {
  value = aws_lb.terraform-lb.dns_name
}
