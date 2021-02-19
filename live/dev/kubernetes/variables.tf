variable "region" {
  default = "eu-west-1"
}

variable environment {
  default = "dev"
}

variable "eks_services" {
  default = {
    endpoint_private_access = true
    endpoint_public_access  = false
  }
}