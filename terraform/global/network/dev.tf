resource "aws_subnet" "dev-pub-eu-west-1a" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.0.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    environment = "dev"
    type = "public"
  }
}

resource "aws_subnet" "dev-pub-eu-west-1b" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.1.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    environment = "dev"
    type = "public"
  }
}

resource "aws_subnet" "dev-pub-eu-west-1c" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.2.0/24"
  availability_zone = "eu-west-1c"

  tags = {
    environment = "dev"
    type = "public"
  }
}

resource "aws_subnet" "dev-prv-eu-west-1a" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.3.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    environment = "dev"
    type = "private"
  }
}

resource "aws_subnet" "dev-prv-eu-west-1b" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.4.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    environment = "dev"
    type = "private"
  }
}

resource "aws_subnet" "dev-prv-eu-west-1c" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.5.0/24"
  availability_zone = "eu-west-1c"

  tags = {
    environment = "dev"
    type = "private"
  }
}

resource "aws_route_table" "dev-rt" {
  vpc_id = aws_default_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-igw.id
  }

  tags = {
    environment = "dev"
  }
}

resource "aws_route_table_association" "dev-pub-eu-west-1a-rt-bind" {
  subnet_id      = aws_subnet.dev-pub-eu-west-1a.id
  route_table_id = aws_route_table.dev-rt.id
}

resource "aws_route_table_association" "dev-pub-eu-west-1b-rt-bind" {
  subnet_id      = aws_subnet.dev-pub-eu-west-1b.id
  route_table_id = aws_route_table.dev-rt.id
}

resource "aws_route_table_association" "dev-pub-eu-west-1c-rt-bind" {
  subnet_id      = aws_subnet.dev-pub-eu-west-1c.id
  route_table_id = aws_route_table.dev-rt.id
}

resource "aws_eip" "dev-eip-ngw" {
  vpc      = true
  
  tags = {
    environment = "dev"
  }
}

resource "aws_nat_gateway" "dev-ngw" {
  allocation_id = aws_eip.dev-eip-ngw.id
  subnet_id     = aws_subnet.dev-pub-eu-west-1a.id
  
  tags = {
    environment = "dev"
  }
}

resource "aws_default_route_table" "dev-prv-rt" {
  default_route_table_id = aws_default_vpc.default.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev-ngw.id
  }

  tags = {
    environment = "dev"
  }
}

resource "aws_route_table_association" "dev-prv-eu-west-1a-rt-bind" {
  subnet_id      = aws_subnet.dev-prv-eu-west-1a.id
  route_table_id = aws_default_route_table.dev-prv-rt.id
}

resource "aws_route_table_association" "dev-prv-eu-west-1b-rt-bind" {
  subnet_id      = aws_subnet.dev-prv-eu-west-1b.id
  route_table_id = aws_default_route_table.dev-prv-rt.id
}

resource "aws_route_table_association" "dev-prv-eu-west-1c-rt-bind" {
  subnet_id      = aws_subnet.dev-prv-eu-west-1c.id
  route_table_id = aws_default_route_table.dev-prv-rt.id
}
