resource "aws_instance" "terraform-instance" {
  count = var.instances_number

  launch_template {
    name = var.aws_launch_template_name
  }

  tags = {
    Name = var.project_name
  }
}
