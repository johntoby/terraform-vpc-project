variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC to attach the Internet Gateway to."
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  
}
