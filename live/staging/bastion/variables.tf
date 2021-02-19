variable "region" {
  default = "eu-west-1"
}

variable environment {
  default = "stg"
}

variable "bastion" {
  default = {
    ami           = "ami-0e5657f6d3c3ea350"
    instance_type = "t2.micro"
    key_name      = "stg-aws-bastion"
    public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSw028FlsB0uNltK+EdWEwS6bhfW8fEmIdjPiMBrOKPJMhhbt/Ce3FoowWlBdiVYNOpZt+R/uxg/SqGKuTTh4J5gjh6dhUcG6sC2Iw12w7dBid/8ALMYuQS0twxnFO5UpKdrWZbM0iT8qaAjEl405S2RxFDvWJEMuHv5HlWYH59YRUfQ4zBZdaCUSnI9+O0hHanALA1BGbNFzpT8c7nToAekye2BYDW0DMP6uAERym0psKdBD5biGHdfHg2aeN/rz6cJXIPt6Zkkut/KNwIqTshGwWmjlMbLAmbgmKqnyouNUT2xz+HczJkh/wj+2awmTrjogOdi4yzk2sG1OoUMXAIEjJowa5u+1cRqECqeAgAMU+NnimxqT4xvALVX+1wpT2OmzEfd9vigcuYq+W0l/f4Cw3c4Eda1g4iR2B9j9jiZ+oGtE2hf3acqerLgHQwhPtBhwayfz6pZqPGEbwxspvAqqHMx5VsOHS+umwPv8K2x1ZH8EDRK/zFYrESiX/JEBUh0v+pDmuHwlXP76L7OirKxfggIS8WICikoXd8VOAtS6icoNrPEMwppXCRGAooMmvLZR/VGXLISDy7UBr9ZLN4clgTsp0cNXoctmyyp0GVK1oOcppz0Mfv2/9M2RIdkEuNn3rUrsrarlRuvEMYy3NxvyYLwhGU8z1zfHEJjabIw=="
  }
}