output "vpc_id" {
  value = data.terraform_remote_state.global.outputs.vpc_id
}

output "ec2_public_ip" {
  value = module.aws_app_instance.ec2_public_ip
}
