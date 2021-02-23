output "sg_bastion_ssh_id" {
  value = aws_security_group.sg_bastion_ssh.id
}

output "external_hostname" {
  value = aws_instance.bastion.public_dns
}
