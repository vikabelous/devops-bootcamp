data "terraform_remote_state" "global" {
  backend = "s3"

  config = {
    bucket = "terraform-state-968919042103"
    key    = "devops_bootcamp/global/terraform_project.tfstate"
    region = "us-west-2"
    profile = "devops_bootcamp"
  }
}

data "local_file" "ssh_rsa_key" {
  filename = "/Users/vbil/.ssh/id_rsa.pub"
}

data "aws_ami" "amazon-hvm-latest" {
  most_recent      = true
  name_regex       = "amzn2-ami-hvm-2.0*"
  owners           = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  project_name = data.terraform_remote_state.global.outputs.project_name
  vpc_id = data.terraform_remote_state.global.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.global.outputs.subnet_ids
}
