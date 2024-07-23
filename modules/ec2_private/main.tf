resource "aws_instance" "private" {
  ami = "ami-0ff591da048329e00" 
  instance_type = "t2.micro"
  subnet_id = var.private_subnet_id
  key_name = var.key_name

  user_data = file(install_postgresql.sh)

  tags = {
    Name = "Private-Instance"
  }

  security_groups = [aws_security_group.private_sg.id]
}

resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [var.public_subnet_cidr]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private-SG"
  }
}


