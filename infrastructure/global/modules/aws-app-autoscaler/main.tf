resource "aws_autoscaling_group" "terraform-autoscaling-group" {
  name_prefix               = "tf-asg"
  max_size                  = 6
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_configuration      = var.aws_launch_template_name
  vpc_zone_identifier       = var.vpc.subnet_ids
  target_group_arns         = [var.lb_tg_arn]

  tag {
    key                 = "Name"
    value               = var.project_name
    propagate_at_launch = true
  }
}
