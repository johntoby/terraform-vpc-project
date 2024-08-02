# terraform-vpc-project
A repository to store my terraform files for custom VPC creation. 

This is a continuation of my earlier project on VPCs which was created using clickops. Now, I am automating the entire infrastructure using Terraform.

## project set up
I am creating a custom VPC called KCVPC, with 2 subnets - private_subnet & public_subnet. Each subnet will house an Ubuntu Instance named ec2_private & ec2_public. Other parts of the infrastructure to be created include Internet Gateway (IGW), Route tables (public and private), NAT Gateway, Security groups and NACLs. Also, the backend is saved in a remote s3 bucket, and the state is locked in a dynamodb table. All these will be created using Infrastructure as Code tool called terraform.

To make my terraform code modular, portable and reusable, I will create 8 modules which will be referenced in my main.tf file. These module are: 
 - vpc
 - subnet
 - webserver
 - dbserver
 - internet_gateway
 - nat_gateway
 - route_table
 - security_group
 

Finally,  I included scripts to automatically an nginx web server on the ec2_public instance and another script to deploy a postgresql server on the ec2_private instance. All the codes for this project are contained in this repository. 

#creating vpc
The first resource to be created is the vpc. After creating the vpc module, it will be referenced as module "vpc" in my main.tf file as shown in the diagram 

![vpc module code](https://github.com/user-attachments/assets/4f7180b8-6a48-412d-8cbd-783deecc071a)

<br>

![module vpc](https://github.com/user-attachments/assets/8f5eea90-f30e-4a75-b8fe-c75a04013190)

<br>


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
