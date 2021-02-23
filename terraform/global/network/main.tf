provider "aws" {
    region = "eu-west-1"
}

terraform {
  backend "s3" {
    key = "global/network/terraform.tfstate"
  }
}

resource "aws_s3_bucket_object" "network_info" {
  bucket = "3673fe-tf-state"
  key    = "global/network/network-info.json"
  content = <<EOF
{
  "default_vpc": "${aws_default_vpc.default.id}",
  "subnets": {
    "dev": {
      "public":{
        "eu-west-1a": "${aws_subnet.dev-pub-eu-west-1a.id}",
        "eu-west-1b": "${aws_subnet.dev-pub-eu-west-1b.id}",
        "eu-west-1c": "${aws_subnet.dev-pub-eu-west-1c.id}"
      },
      "private":{
        "eu-west-1a": "${aws_subnet.dev-prv-eu-west-1a.id}",
        "eu-west-1b": "${aws_subnet.dev-prv-eu-west-1b.id}",
        "eu-west-1c": "${aws_subnet.dev-prv-eu-west-1c.id}"
      }
    },
    "stg": {
      "public":{
        "eu-west-1a": "${aws_subnet.stg-pub-eu-west-1a.id}",
        "eu-west-1b": "${aws_subnet.stg-pub-eu-west-1b.id}",
        "eu-west-1c": "${aws_subnet.stg-pub-eu-west-1c.id}"
      },
      "private":{
        "eu-west-1a": "${aws_subnet.stg-prv-eu-west-1a.id}",
        "eu-west-1b": "${aws_subnet.stg-prv-eu-west-1b.id}",
        "eu-west-1c": "${aws_subnet.stg-prv-eu-west-1c.id}"
      }
    }
  }
}
EOF
  content_type = "application/json"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_internet_gateway" "default-igw" {
  vpc_id = aws_default_vpc.default.id

  tags = {
    Name = "Default IGW"
  }
}
