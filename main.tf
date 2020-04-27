resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = "t3.micro"
  subnet_id     = "${aws_subnet.ap-northeast-1-public.id}"

  tags = {
    Name = "example"
  }

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctrl start httpd.service
  EOF
}

resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "ap-northeast-1-public" {
  vpc_id            = "${aws_vpc.example.id}"
  cidr_block        = "10.0.1.0/25"
  availability_zone = "ap-northeast-1a"
}
