#create VPC

resource "aws_vpc" "vp1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Elb-vpc"
    Team = "wdp"
    env  = "dev"
  }
}

# Internet gateway
resource "aws_internet_gateway" "gtw1" {
  vpc_id = aws_vpc.vp1.id
}


#public subnet1
resource "aws_subnet" "public1" {
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vp1.id
  tags = {
    Name = "utc-public-subnet-1a"
  }
}

#public subnet2
resource "aws_subnet" "public2" {
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vp1.id
  tags = {
    Name = "utc-public-subnet-1b"
  }
}

#private subnet1
resource "aws_subnet" "private1" {
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.3.0/24"
  vpc_id            = aws_vpc.vp1.id
  tags = {
    Name = "utc-private-subnet-1a"
  }
}

#private subnet2
resource "aws_subnet" "private2" {
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.4.0/24"
  vpc_id            = aws_vpc.vp1.id
  tags = {
    Name = "utc-private-subnet-1b"
  }
}

#Nat Gateway

resource "aws_eip" "el1" {

}

resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.el1.id
  subnet_id     = aws_subnet.public1.id
}

#Route public Table

resource "aws_route_table" "rtpu" {
  vpc_id = aws_vpc.vp1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtw1.id
  }
}

#Route private Table

resource "aws_route_table" "rtpri" {
  vpc_id = aws_vpc.vp1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
}



# route and public subnet association

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.rtpu.id
}
resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.rtpu.id
}



# route and private subnet association

resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.rtpri.id
}
resource "aws_route_table_association" "rta4" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.rtpri.id
}
