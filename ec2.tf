resource "aws_instance" "sever1" {

  availability_zone = "us-east-1a"
  ami               = "ami-03972092c42e8c0ca"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.private1.id
  security_groups   = [aws_security_group.sg-demo1.id]
  user_data         = file("userdata.sh")
  tags = {
    Name = "web1"
  }
}

resource "aws_instance" "sever2" {

  availability_zone = "us-east-1b"
  ami               = "ami-03972092c42e8c0ca"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.private2.id
  security_groups   = [aws_security_group.sg-demo1.id]
  user_data         = file("userdata.sh")
  tags = {
    Name = "web2"
  }
}
