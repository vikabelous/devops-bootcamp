resource "aws_security_group" "terraform-lb" {
  name_prefix = "allow_http-"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc.vpc_id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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

resource "aws_lb" "terraform-lb" {
  name_prefix        = "tf-lb-"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terraform-lb.id]
  subnets            = var.vpc.subnet_ids

  tags = {
    Name = var.project_name
  }
}

resource "aws_lb_listener" "terraform-lb-listener" {
  load_balancer_arn = aws_lb.terraform-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform-lb-target-group.arn
  }
}

resource "aws_lb_target_group" "terraform-lb-target-group" {
  name_prefix = "lbtg-"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc.vpc_id

  health_check {
    interval  = 5
    timeout   = 2
    path      = "/kittens/info"
  }
}

resource "aws_lb_target_group_attachment" "terraform-lb-tg-instance-attachment" {
  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.terraform-lb-target-group.arn
  target_id        = element(var.instance_ids, count.index)
  port             = 80
}

resource "aws_autoscaling_attachment" "terraform-lb-asg-attachment" {
  autoscaling_group_name = var.autoscaling_group_id
  alb_target_group_arn   = aws_lb_target_group.terraform-lb-target-group.arn
}
