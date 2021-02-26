provider "aws" {
    region = var.region
}

terraform {
  backend "s3" {
    key = "dev/vault/terraform.tfstate"
  }
}

## variables & data sources block

locals {
  network_info = jsondecode(data.aws_s3_bucket_object.network_info.body)
  bastion_info = jsondecode(data.aws_s3_bucket_object.bastion_info.body)
}

data "aws_s3_bucket_object" "network_info" {
  bucket = "3673fe-tf-state"
  key    = "global/network/network-info.json"
}

data "aws_s3_bucket_object" "bastion_info" {
  bucket = "3673fe-tf-state"
  key    = "dev/bastion/bastion-info.json"
}

## modules block

module "vault" {
    source                      = "../../../modules/instances/ec2"
    bastion_security_group_id   = local.bastion_info["bastion_sg_id"]
    ami                         = var.vault.ami
    instance_type               = var.vault.instance_type
    availability_zones          = var.vault.availability_zones
    associate_public_ip_address = var.vault.associate_public_ip_address
    key_name                    = var.vault.key_name
    public_key                  = var.vault.public_key
    vpc_id                      = local.network_info["default_vpc"]
    subnet_id                   = local.network_info["subnets"][var.environment]["private"]
    environment                 = var.environment
    role                        = var.role
}

## resources block

resource "null_resource" "vault_private_key_to_bastion" {

  provisioner "file" {
    source      = "~/.ssh/dev-aws-vault"
    destination = "~/.ssh/dev-aws-vault.pem"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/dev-aws-bastion")
      host        = local.bastion_info["bastion_external_hostname"]
    }
  }

  provisioner "remote-exec" {
    ## if you delete the vault ec2, the key will not be removed from the bastion!
    ## strange error after reapply Upload failed: scp: /home/ubuntu/.ssh/dev-aws-vault.pem: Permission denied
    inline = [
      "chmod 400 ~/.ssh/dev-aws-vault.pem"
    ]
    
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/dev-aws-bastion")
      host        = local.bastion_info["bastion_external_hostname"]
    }
  }

}

resource "aws_security_group" "vault_servers_traffic" {
  name = format("%s-%s-servers-traffic", var.environment, var.role)
  description = "Allow Vault servers traffic"

  ingress {
    from_port = 8200
    to_port = 8200
    protocol = "tcp"
    cidr_blocks = ["172.31.3.0/24"]
  }
  ingress {
    from_port = 8200
    to_port = 8200
    protocol = "tcp"
    cidr_blocks = ["172.31.4.0/24"]
  }
  ingress {
    from_port = 8200
    to_port = 8200
    protocol = "tcp"
    cidr_blocks = ["172.31.5.0/24"]
  }

  ingress {
    from_port = 8201
    to_port = 8201
    protocol = "tcp"
    cidr_blocks = ["172.31.3.0/24"]
  }

  ingress {
    from_port = 8201
    to_port = 8201
    protocol = "tcp"
    cidr_blocks = ["172.31.4.0/24"]
  }

  ingress {
    from_port = 8201
    to_port = 8201
    protocol = "tcp"
    cidr_blocks = ["172.31.5.0/24"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = local.network_info["default_vpc"]
  
  tags = {
    role = format("%s-to-%s",var.role, var.role)
    environment = var.environment
  }
}
