provider "aws" {
    region = var.region
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

terraform {
  backend "s3" {
  key = "dev/eks-services/terraform.tfstate"
  }
}

data "aws_s3_bucket_object" "network_info" {
  bucket = "3673fe-tf-state"
  key    = "global/network/network-info.json"
}

module "eks-services" {
    source        = "../../../modules/eks"
    subnet_ids           = [jsondecode(data.aws_s3_bucket_object.network_info.body)["subnets"]["dev-1"],jsondecode(data.aws_s3_bucket_object.network_info.body)["subnets"]["dev-1"]]
    endpoint_private_access = var.eks_services.endpoint_private_access
    endpoint_public_access = var.eks_services.endpoint_public_access
    environment = var.environment
}
