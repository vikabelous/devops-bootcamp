## Modules
module "terraform-http-ip" {
  source = "jameswoolfenden/ip/http"
  version= "0.3.2"
}

### EC2
module "aws_app_instance" {
  source = "./modules/aws-app-instance"

  project_name = local.project_name
  ami_id = data.aws_ami.amazon-hvm-latest.id

  vpc_id = local.vpc_id
  subnet_id = local.subnet_ids[0]

  ssh_cidr_block = module.terraform-http-ip.cidr
  ssh_key_pub = data.local_file.ssh_rsa_key.content
}

