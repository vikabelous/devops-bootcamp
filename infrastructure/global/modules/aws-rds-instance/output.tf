output "host" {
  value       = aws_db_instance.terraform-rds.address
  description = "RDS host"
}

output "database" {
  value       = aws_db_instance.terraform-rds.name
  description = "RDS database"
}

output "user" {
  value       = aws_db_instance.terraform-rds.username
  description = "RDS database username"
}

output "password" {
  value       = aws_db_instance.terraform-rds.password
  description = "RDS database password"
  sensitive   = true
}

output "connection_url" {
  value       = "postgres://${aws_db_instance.terraform-rds.username}:${aws_db_instance.terraform-rds.password}@${aws_db_instance.terraform-rds.endpoint}/${aws_db_instance.terraform-rds.name}"
  description = "RDS connection url"
}

output "connection_security_group_id" {
  value = aws_security_group.terraform-db-connector.id
}
