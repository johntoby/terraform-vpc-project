# outputs after terraform apply

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.public_subnet.subnet_id
}

output "private_subnet_id" {
  value = module.private_subnet.subnet_id
}

output "webserver_id" {
  value = module.webserver.instance_id
}

output "dbserver_id" {
  value = module.dbserver.instance_id
}

