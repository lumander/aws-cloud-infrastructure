resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "sg_bastion_ssh" {
  name = format("%s-bastion-ssh",var.environment)
  description = "Allow SSH to Bastion host from approved ranges"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["37.117.147.213/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = var.vpc_id
  
  tags = {
    role = "external-to-bastion-ssh"
    environment = var.environment
  }

}

resource "aws_instance" "bastion" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.id
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.sg_bastion_ssh.id ]
  subnet_id = var.subnet_id

  tags = {
    role = "bastion"
    environment = var.environment
  }

}
