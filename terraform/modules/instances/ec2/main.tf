resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "sg_access_from_bastion_ssh" {
  name = format("%s-%s-bastion-ssh", var.environment, var.role)
  description = "Allow SSH From Bastion host security group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [var.bastion_security_group_id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = var.vpc_id
  
  tags = {
    role = format("bastion-to-%s-ssh",var.role)
    environment = var.environment
  }
}

locals {
  unique_ec2s = flatten([
    for zone, numbers in var.availability_zones : [
      for number in range(1, numbers+1) : { 
        zone = zone
        id = number
      }
    ]
  ])
}

resource "aws_instance" "ec2" {
  for_each = {
      for ec2 in local.unique_ec2s : "${ec2.zone}:${ec2.id}" => ec2
    }

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids = [ aws_security_group.sg_access_from_bastion_ssh.id ]
  subnet_id = var.subnet_id[each.value.zone]

  tags = {
    role = var.role
    environment = var.environment
  }

}
