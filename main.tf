module "vpc" {
  source = "./vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "public_subnet" {
  source = "./public_subnet"
  vpc_id = module.vpc.vpc_id
  subnet_cidr = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
}

module "private_subnet" {
  source = "./private_subnet"
  vpc_id = module.vpc.vpc_id
  subnet_cidr = "10.0.2.0/24"
  availability_zone = "eu-west-1a"
}

module "ec2_public" {
  source = "./ec2_public"
  subnet_id = module.public_subnet.subnet_id
  key_name = var.key_name
  install_script = "./scripts/install_nginx.sh"
}

module "ec2_private" {
  source = "./ec2_private"
  subnet_id = module.private_subnet.subnet_id
  key_name = var.key_name
  install_script = "./scripts/install_postgresql.sh"
}


