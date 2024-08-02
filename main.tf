
module "vpc" {
  source                    = "./modules/vpc"
  cidr_block                = var.vpc_cidr_block
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  vpc_id                    = module.vpc.vpc_id
}

module "public_subnet" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
  name                    = "PublicSubnet"
}

module "private_subnet" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = var.private_subnet_cidr_block
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = false
  name                    = "PrivateSubnet"

}

module "igw" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  name   = "kc_IGW"
}

module "nat_gateway" {
  source    = "./modules/nat_gateway"
  subnet_id = module.public_subnet.subnet_id
}

module "public_route_table" {
  source     = "./modules/route_table"
  vpc_id     = module.vpc.vpc_id
  gateway_id = module.igw.igw_id
  subnet_id  = module.public_subnet.subnet_id
  name       = "Kcvpc_public-route-table"
}

module "private_route_table" {
  source     = "./modules/route_table"
  vpc_id     = module.vpc.vpc_id
  gateway_id = module.nat_gateway.nat_gateway_id
  subnet_id  = module.private_subnet.subnet_id
  name       = "Kcvpc_private-route-table"
}

module "public_security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  name   = "Public-SG"
  ingress = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["197.210.52.208/32"]
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "private_security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  name   = "Private-SG"
  ingress = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["10.0.1.0/24"]
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "webserver" {
  source            = "./modules/webserver"
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  subnet_id         = module.public_subnet.subnet_id
  security_groups   = [module.vpc.public_sg_id]
  availability_zone = "eu-west-1a"
  name              = "webserver"
  description       = "webserver"
  user_data         = file("${path.module}/scripts/install_nginx.sh")
}

module "dbserver" {
  source             = "./modules/dbserver"
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key_name
  subnet_id          = module.private_subnet.subnet_id
  security_group_ids = [module.vpc.private_sg_id]
  availability_zone  = "eu-west-1a"
  name               = "dbserver"
  description        = "database"
  user_data          = file("${path.module}/scripts/install_postgresql.sh")
}

resource "aws_key_pair" "kc-terraform-keypair" {
  key_name   = var.key_name
  public_key = var.public_key_path
}


