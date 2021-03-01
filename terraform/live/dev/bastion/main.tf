provider "aws" {
    region = var.region
}

locals {
  network_info = jsondecode(data.aws_s3_bucket_object.network_info.body)
}

terraform {
  backend "s3" {
    key = "dev/bastion/terraform.tfstate"
  }
}

data "aws_s3_bucket_object" "network_info" {
  bucket = "3673fe-tf-state"
  key    = "global/network/network-info.json"
}

module "bastion" {
    source              = "../../../modules/instances/bastion"
    ami                 = var.bastion.ami
    instance_type       = var.bastion.instance_type
    key_name            = var.bastion.key_name
    public_key          = var.bastion.public_key
    trusted_cidr_blocks = var.bastion.trusted_cidr_blocks
    vpc_id              = local.network_info["default_vpc"]
    subnet_id           = local.network_info["subnets"]["dev"]["public"]["eu-west-1a"]
    environment         = var.environment
}

resource "aws_s3_bucket_object" "bastion_info" {
  bucket = "3673fe-tf-state"
  key    = "dev/bastion/bastion-info.json"
  content = <<EOF
{
  "bastion_sg_id": "${module.bastion.sg_bastion_ssh_id}",
  "bastion_external_hostname" : "${module.bastion.external_hostname}"
}
EOF
  content_type = "application/json"
}
