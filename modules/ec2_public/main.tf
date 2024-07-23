resource "aws_instance" "public" {
  ami = "ami-12345678" # Replace with your desired Ubuntu AMI
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  key_name = var.key_name

  user_data = file(install_nginx.sh)

  tags = {
    Name = "Public-Instance"
  }

  security_groups = [aws_security_group.public_sg.id]
}

resource "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public-SG"
  }
}


