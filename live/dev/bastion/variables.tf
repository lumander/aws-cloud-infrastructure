variable "region" {
  default = "eu-west-1"
}

variable environment {
  default = "dev"
}

variable "bastion" {
  default = {
    ami           = "ami-0e5657f6d3c3ea350"
    instance_type = "t2.micro"
    key_name      = "dev-aws-bastion"
    public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQa+czFqBf/OouSFQNx++zxJf95EzHjfCXmG84dY4m7CwvusumzDCCX5HTp6aFe4DSTjPQXO8XfxhSOnzKaKfgjCWH3EtS/eJukZxYMwwORyroUoviHJeLnYhjKX8Nf4XDKxQrIYIEmAt4FXLYkgFo3LhKU/2EOPrVVOKEs3MaGhgK4psqete64XO0HDkR5MZrvn4KrXh1KuEyC56lK7M27zrw4fUuDAhkS60LCQ4dQh8zhgMzXq/vA/IC2FAJX3N2t22M3qnsu6BIbVJrR1TroYqaDkf/sCvfpgdsEmHfRI1Q9K+8wcI4yvOpCThSPxKE5RPr0Scn5RHSqgZZuPfsxpW+tL5yCbz1RuAtqge9iB64bC+N2uNHfkBLaAMV3PwB4MNZL932rFZploVnoRmiUuS3BA+ApPrPkALAor6RIO9D9c2bUOZ2e6MvklWkzJpf7npHvLcUeYSLPi3ZqQRMJULfEw2NP6/Wjp2vpHIFc7o2rQLBsaGFw2/3zENE1UDI/5EnOfKSBiFVDDyCoLDq35lotY8V2GUZjT0D9we3PVeU+Ium8QBAgAbdKxarFSsHcokVb8zizXQ7gfMluFMpzav7LbaYYssb2QrEVRg5xFbZTXgCL0MLKIGr5p1tZrDD3bb/fyjPWHtFUGBFjbyo85A6S5UxUy94psOEW3nK0Q=="
  }
}