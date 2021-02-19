provider "aws" {
    region = var.region
}

locals {
  network_info = jsondecode(data.aws_s3_bucket_object.network_info.body)
  bastion_info = jsondecode(data.aws_s3_bucket_object.bastion_info.body)
}

terraform {
  backend "s3" {
    key = "dev/vault/terraform.tfstate"
  }
}

data "aws_s3_bucket_object" "network_info" {
  bucket = "3673fe-tf-state"
  key    = "global/network/network-info.json"
}

data "aws_s3_bucket_object" "bastion_info" {
  bucket = "3673fe-tf-state"
  key    = "dev/bastion/bastion-info.json"
}

module "vault" {
    source        = "../../../modules/instances/ec2"
    bastion_security_group_id = local.bastion_info["bastion_sg_id"]
    ami           = var.vault.ami
    instance_type = var.vault.instance_type
    availability_zones = toset(var.vault.availability_zones)
    associate_public_ip_address = var.vault.associate_public_ip_address
    key_name      = var.vault.key_name
    public_key    = var.vault.public_key
    vpc_id        = local.network_info["default_vpc"]
    subnet_id     = local.network_info["subnets"][var.environment]["private"]
    environment   = var.environment
    role = var.role
}

## move to ansible
resource "null_resource" "vault_private_key_to_bastion" {

  provisioner "file" {
    source      = "/home/lumander/.ssh/dev-aws-vault"
    destination = "~/.ssh/dev-aws-vault"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/dev-aws-bastion")
      host        = local.bastion_info["bastion_external_hostname"]
    }
  }

}


