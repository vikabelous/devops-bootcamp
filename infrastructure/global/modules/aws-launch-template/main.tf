resource "aws_launch_configuration" "terraform-launch-configuration" {
  image_id      = var.ami_id
  instance_type = "t2.micro"

  key_name                    = aws_key_pair.terraform-key-pair.key_name
  associate_public_ip_address = true
  security_groups             = concat([aws_security_group.terraform-ec2.id], var.assigned_security_groups)

  user_data = var.user_data

  lifecycle {
    ignore_changes = [
      image_id
    ]
  }
}

resource "aws_key_pair" "terraform-key-pair" {
  key_name_prefix = "terraform-"
  public_key      = var.ssh_key_pub
}

resource "aws_security_group" "terraform-ec2" {
  name_prefix = "allow_ssh_http-"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc.vpc_id

  ingress {
    description = "SSH from personal IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr_block]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [var.lb_security_group_id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.project_name
  }
}
