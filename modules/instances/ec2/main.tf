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

  vpc_id = var.vpc_id
  
  tags = {
    role = format("bastion-to-%s-ssh",var.role)
    environment = var.environment
  }
}

resource "aws_instance" "ec2" {
for_each = var.availability_zones

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids = [ aws_security_group.sg_access_from_bastion_ssh.id ]
  subnet_id = var.subnet_id[each.value]

  tags = {
    role = var.role
    environment = var.environment
  }

}
