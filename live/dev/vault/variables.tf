variable "region" {
  default = "eu-west-1"
}

variable environment {
  default = "dev"
}

variable role {
  default = "vault"
}

# ssh-keygen -t rsa -b 4096 -m PEM

variable "vault" {
  default = {
    ami           = "ami-0e5657f6d3c3ea350"
    instance_type = "t2.micro"
    associate_public_ip_address = false
    key_name      = "dev-aws-vault"
    public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJ2kxBmlhMphJxsagJAu8kpmyQdhYxODa9wsb1T36DUyi7k1e6JbJa9rszYKYT6HhAJkAtfP0wFyLUnvdJGIUQt2YsrsS9rP0z8bsVgL257esmPIzHHahvxOFnb2+WNowBxCIKy6pgYvaqL5ZwMqroDqHdc5QZlyR5CUfJTAlZM5xMDMU8FLlTaMe4ZKggexQIm7RSU59TONPU0blaaLcSz3TKF5/w7bExo0aL3oZ6uVxoESHfGm8fFTsZ3el4jmHiy0LF7Ria/agwtSL7PtOq3cO9bvel2Hu3aDL5Jr7JVVKD4s+kxhl4QMmB2iD0jB5yXajskPh7KmHDfbiliujrgugGeZmSw1lEcR8qrJJcNh9QS8GAddpoJGG+80IqWR8GaApblRZc50yfvM2Eu1jw5O4yGu6MjSNA3S2MBBq0uunOgIgcHXvCMspx1AukXEHvimhoP+WQtgWeXS/7J28Q0Vhat3RmZbymkVMtlqDWelaPz3SMw83/OkvnP8FZ9q/5U9k5vBlY+UEBddPR1jtBuGF/f55oaCYXZJCPbS3DC8Tqq5sWn0ARl9OjvfH3G77iMavu86rK0JYTKsU78jwTrv0bmsEjvMuAginw74NqlIurZy7BntJXBBOCd6L9dh9apTyPv47U75Iu1SfMLtJbD5tKOEjHQZ9S/cx+97aCZw=="
    availability_zones = {
      "eu-west-1a" = 2
      "eu-west-1b" = 1
      "eu-west-1c" = 1
    }
  }
}
