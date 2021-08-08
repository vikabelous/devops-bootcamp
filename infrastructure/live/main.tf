## Modules
module "terraform-http-ip" {
  source = "jameswoolfenden/ip/http"
  version= "0.3.2"
}

### RDS
module "aws_rds_instance" {
  source = "../global/modules/aws-rds-instance"

  project_name = local.project_name
  vpc = local.vpc
}

### Launch template

module "aws_launch_template" {
  source = "../global/modules/aws-launch-template"

  project_name = local.project_name

  ami_id = data.aws_ami.amazon-hvm-latest.id
  vpc = local.vpc

  ssh_cidr_block = module.terraform-http-ip.cidr
  ssh_key_pub = data.local_file.ssh_rsa_key.content

  assigned_security_groups = [module.aws_rds_instance.connection_security_group_id]
  lb_security_group_id = module.aws_lb.lb_security_group_id
  user_data = data.template_file.run_app.rendered
}

### EC2
module "aws_app_instance" {
  source = "../global/modules/aws-app-instance"

  project_name = local.project_name
  instances_number = local.instances_number

  aws_launch_template_name = module.aws_launch_template.aws_launch_template_name
}

## ASG
module "aws_app_autoscaler" {
  source = "../global/modules/aws-app-autoscaler"

  project_name = local.project_name

  vpc = local.vpc
  lb_tg_arn = module.aws_lb.lb_tg_arn

  aws_launch_template_name = module.aws_launch_template.aws_launch_template_name
}

### LB
module "aws_lb" {
  source = "../global/modules/aws-lb"

  project_name = local.project_name
  vpc = local.vpc

  instance_ids = module.aws_app_instance.ec2_ids
  autoscaling_group_id = module.aws_app_autoscaler.autoscaling_group_id
}
