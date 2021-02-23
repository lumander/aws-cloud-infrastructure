provider "aws" {
    region = var.region
}

locals {
  network_info = jsondecode(data.aws_s3_bucket_object.network_info.body)
}

terraform {
  backend "s3" {
  key = "stg/bastion/terraform.tfstate"
  }
}

data "aws_s3_bucket_object" "network_info" {
  bucket = "3673fe-tf-state"
  key    = "global/network/network-info.json"
}

module "bastion" {
    source        = "../../../modules/instances/bastion"
    ami           = var.bastion.ami
    instance_type = var.bastion.instance_type
    key_name      = var.bastion.key_name
    public_key    = var.bastion.public_key
    vpc_id        = local.network_info["default_vpc"]
    subnet_id     = local.network_info["subnets"]["stg"]["public"]["eu-west-1c"]
    environment   = var.environment
}
