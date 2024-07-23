resource "aws_subnet" "private" {
  vpc_id = var.vpc_id
  cidr_block = var.vpc_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = var.private_route_table_id
}
