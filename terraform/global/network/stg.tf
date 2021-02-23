resource "aws_subnet" "stg-pub-eu-west-1a" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.6.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    environment = "stg"
    type = "public"
  }
}

resource "aws_subnet" "stg-pub-eu-west-1b" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.7.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    environment = "stg"
    type = "public"
  }
}

resource "aws_subnet" "stg-pub-eu-west-1c" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.8.0/24"
  availability_zone = "eu-west-1c"

  tags = {
    environment = "stg"
    type = "public"
  }
}

resource "aws_subnet" "stg-prv-eu-west-1a" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.9.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    environment = "stg"
    type = "private"
  }
}

resource "aws_subnet" "stg-prv-eu-west-1b" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.10.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    environment = "stg"
    type = "private"
  }
}

resource "aws_subnet" "stg-prv-eu-west-1c" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.11.0/24"
  availability_zone = "eu-west-1c"

  tags = {
    environment = "stg"
    type = "private"
  }
}

resource "aws_route_table" "stg-rt" {
  vpc_id = aws_default_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-igw.id
  }

  tags = {
    environment = "stg"
  }
}

resource "aws_route_table_association" "stg-pub-eu-west-1a-rt-bind" {
  subnet_id      = aws_subnet.stg-pub-eu-west-1a.id
  route_table_id = aws_route_table.stg-rt.id
}

resource "aws_route_table_association" "stg-pub-eu-west-1b-rt-bind" {
  subnet_id      = aws_subnet.stg-pub-eu-west-1b.id
  route_table_id = aws_route_table.stg-rt.id
}

resource "aws_route_table_association" "stg-pub-eu-west-1c-rt-bind" {
  subnet_id      = aws_subnet.stg-pub-eu-west-1c.id
  route_table_id = aws_route_table.stg-rt.id
}
