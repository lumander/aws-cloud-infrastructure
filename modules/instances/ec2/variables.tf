variable "key_name" {
    type = string
    description = "Name of the public key deployed on aws"
}

variable "public_key" {
    type = string
    description = "Public key deployed on aws"
}

variable "bastion_security_group_id" {
    type = string
    description = "Security group of the bastion host"
}

variable "ami" {
    type = string
    description = "AMI identifier"
}

variable "instance_type" {
    type = string
    description = "Instance type"
}

variable "vpc_id" {
    type = string
    description = "VPC id"
}

variable "subnet_id" {
    type = map(string)
    description = "Map containing the bind between zones and subnets"
}

variable "availability_zones" {
    type = list(string)
    description = "List of the availability zones where to deploy"
}

variable "associate_public_ip_address" {
    type = bool
    description = "Whether to associate a public ip or not"
}

variable "role" {
    type = string
    description = "Logical purpose of the machine - used for tags"
}

variable "environment" {
    type = string
    description = "Environment where the machine is deployed - used for tags"
    validation {
      condition     = var.environment == "dev" || var.environment == "stg" 
      error_message = "The environment must be set!"
  }
}
