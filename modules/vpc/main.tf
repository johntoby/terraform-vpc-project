resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "kc-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = "eu-west-1a"
}

resource "aws_security_group" "public_sg" {
  name_prefix = "public-"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group" "private_sg" {
  name_prefix = "private-"
  vpc_id      = aws_vpc.main.id
}

