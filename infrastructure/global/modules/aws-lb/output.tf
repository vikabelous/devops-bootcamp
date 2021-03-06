output "lb_security_group_id" {
  value = aws_security_group.terraform-lb.id
}

output "lb_dns" {
  value = aws_lb.terraform-lb.dns_name
}

output "lb_tg_arn" {
  value = aws_lb_target_group.terraform-lb-target-group.arn
}
