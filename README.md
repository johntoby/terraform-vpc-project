# terraform-vpc-project
A repository to store my terraform files for custom VPC creation. 

This is a continuation of my earlier project on VPCs which was created using clickops. Now, I am automating the entire infrastructure using Terraform.

## project set up
I am creating a custom VPC called KCVPC, with 2 subnets - private_subnet & public_subnet. Each subnet will house an Ubuntu Instance named ec2_private & ec2_public. 

I set up 5 modules, a module for vpc, public_subnet, private_subnet, ec2_private and ec2_public. These modules will be referenced in my main.tf file to make my codebase simple, clear and modular.

Other parts of the VPC architecture I am adding include Internet Gateway (IGW), Route tables (public and private), NAT Gateway, Security groups and NACLs. Also, the backend is saved in a remote s3 bucket, and the state is locked in a dynamodb table.

Finally,  I included scripts to automatically an nginx web server on the ec2_public instance and another script to deploy a postgresql server on the ec2_private instance.


## deploying the setup 
To deploy the setup, run this command 
```bash
$ terraform init                     # to initialize the terraform configuration, download the modules and state files
$ terraform validate                 # to validate if the configuration is syntactically correct
$ terraform fmt                     # to format the configuration files to meet best practices
$ terraform plan -out tfplan.txt    # to create a plan of the infrastructure and save it as a file named tfplan.txt
$ terraform apply                    # to create the infrastructure

#Its best practice to destroy the infrastructure when you're done, so as not to accumulate cloud costs. Run this command to destroy all the infrastructure:
$ terraform destroy
```

### end 
