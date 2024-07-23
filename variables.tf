variable "key_name" {
  description = "Key name of the EC2 instance"
  default = "KCVPC-KEYPAIR"
}


variable "availability_zone" {
  description = "the avaialbility zone for my subnets"
  default = "eu-west-1a"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "my_ip" {
  description = "My IP address for SSH access"
  default = "197.210.77.56"
}


variable "public_subnet_id" {
  description = "the id of my subnet"
  default = "aws_subnet.public.id"
  }

variable "private_subnet_id" {
  description = "the id of my subnet"
  default = "aws_subnet.private.id"
  }

