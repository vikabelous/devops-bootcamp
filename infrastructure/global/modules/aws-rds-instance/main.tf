resource "random_password" "password" {
  length  = 16
  special = false
  lower   = true
  upper   = true
  number  = true
}

resource "aws_security_group" "terraform-db-connector" {
  name_prefix = "db-connector-"
  vpc_id      = var.vpc.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.project_name
  }
}

resource "aws_security_group" "terraform-postgres" {
  name_prefix = "allow-postgres-access-"
  vpc_id      = var.vpc.vpc_id

  ingress {
    description = "Allow Postgres access from db-connector security group"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.terraform-db-connector.id]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.project_name
  }
}

resource "aws_db_subnet_group" "terraform-db-subnet-group" {
  name_prefix = "terraform-db-subnet-group-"
  subnet_ids  = var.vpc.subnet_ids

  tags = {
    Name = var.project_name
  }
}

resource "aws_db_instance" "terraform-rds" {
  identifier_prefix = "terraform-rds-"

  instance_class    = "db.t2.micro"
  engine            = "postgres"
  engine_version    = "11.11"
  allocated_storage = 20

  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.terraform-db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.terraform-postgres.id]
  skip_final_snapshot    = true

  password = random_password.password.result
  username = "kitten"
  name     = "kittens_store"
}
