# terraform-vpc-project
A repository to store my terraform files for custom VPC creation. 

This is a continuation of my earlier project on VPCs which was created using clickops. Now, I am automating the entire infrastructure using Terraform.

## project set up
I am creating a custom VPC called KCVPC, with 2 subnets - private_subnet & public_subnet. Each subnet will house an Ubuntu Instance named ec2_private & ec2_public. Other parts of the infrastructure to be created include Internet Gateway (IGW), Route tables (public and private), NAT Gateway, Security groups and NACLs. Also, the backend is saved in a remote s3 bucket, and the state is locked in a dynamodb table. All these will be created using Infrastructure as Code tool called Terraform.

To make my terraform code modular, portable and reusable, I will create 8 modules which will be referenced in my main.tf file. These modules are: 
 - vpc
 - subnet
 - webserver
 - dbserver
 - internet_gateway
 - nat_gateway
 - route_table
 - security_group
 

Finally,  I included scripts to automatically install an nginx web server on the ec2_public instance and another script to deploy a postgresql server on the ec2_private instance. All the codes for this project are contained in this repository. 

This is the architectural diagram of the design I will be creating: 

![architectural-diagram](https://github.com/user-attachments/assets/9d3531e0-f22d-4481-92ec-c5c245e4f3aa)


## creating vpc
The first resource to be created is the vpc. After creating the vpc module, it will be referenced as module "vpc" in my main.tf file as shown in the diagram 

![vpc module code](images/vpc-module-code.png)



![module vpc](https://github.com/user-attachments/assets/8f5eea90-f30e-4a75-b8fe-c75a04013190)


## creating subnets
A subnet module will be created which will be a template that I will use to create further subnets: 

![creating subnet module](https://github.com/user-attachments/assets/67dc631b-9317-4fdd-98d9-d4d17246f267)



Two subnets will be created, a publicSubnet and a privateSubnet in the main.tf file, referencing the child module subnet created above.

![module public and private subnet](https://github.com/user-attachments/assets/bccee707-6fb2-4775-9e25-88d679714863)


## creating internet gateway 
An internet gateway named kc-igw will be created as shown below. This will be used by the public subnet to connect to the internet.

![internet gateway](https://github.com/user-attachments/assets/097d4322-60a6-47c1-9b6f-e6ed9db17c9b)


## Creating route tables.
A route table child module will be created to serve as a template for my route tables. In the main.tf file, this will be referenced to create two separate routa tables - public_route_table and private_route_table. 

![route-table-module](https://github.com/user-attachments/assets/f744d1bc-9e12-4582-9e79-ee433c1da6fb)

![route table module](https://github.com/user-attachments/assets/483d1cb8-9989-4ab9-ba32-be7cc3d4457b)





## Configuring NAT gateway
A nat Gateway will be configured in the public subnet. This will also include creating an elastic ip for the NAT gateway to use. 


![module-nat-gateway](https://github.com/user-attachments/assets/d7382a24-d352-43f0-81ed-495b046bafbb)


## creating security groups 
Security groups are the Cloud firewalls that deny or allow traffic to specific ports based on set configurations. Two security groups will be created - privateSG and publicSG for both the private and public subnets. 


![private security group](https://github.com/user-attachments/assets/84de5f53-9499-45bd-b73c-5b02c6da967f)


![public security group](https://github.com/user-attachments/assets/6a4da192-fb6d-442b-82fd-12293e3349a3)


## Creating network access control lists
Network acls are an additional layer of security over the VPC to further deny or allow traffic. We will be creating nacl for both the public and private subnets 


![creating-nacl-for-private-subnet](https://github.com/user-attachments/assets/c167c20a-ab65-447b-884f-9f0b6e32d415)


![creating nacl for public subnet](https://github.com/user-attachments/assets/62ec6f1d-7e6c-486c-95a6-35a9388a1df3)


## creating ec2 instances 
Two instances will be created named webserver and dbserver. The webserver instance will be created in the public subnet while the dbserver will be in the private subnet

![dbserver](https://github.com/user-attachments/assets/25a27d5d-9fed-44c8-8b7a-de98f262ba87)

![webserver](https://github.com/user-attachments/assets/dbc1bb45-c22e-4da5-81c4-716c68e02090)

## creating key pair
An ssh key pair will be created to enable us access the ec2 instances 

![keypair](https://github.com/user-attachments/assets/68b7f4ea-ace3-467d-8585-82ce005014d6)

## creating backend 
A remote backend will be created to store the tfstate file in an s3 bucket, and locked in a dynamodb table. The configuration is shown in the screenshot below: 

![backend](https://github.com/user-attachments/assets/a987fa69-6233-467c-a763-129c605f33c9)



## Deploying the setup 
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

Here are screenshots of the results of the terraform code 

### terraform init

![terraform-init-backend](https://github.com/user-attachments/assets/48248233-e348-4345-b615-d156cc4dd817)

![terraform-successfully-initialized](https://github.com/user-attachments/assets/63d82c67-78ba-4356-a16f-7b74cc43abec)

### terraform validate 
![terraform-validate-command](https://github.com/user-attachments/assets/6cfcb867-d7ba-46d7-9bb8-945343f90ce3)

### terraform plan 
![terraform-plan](https://github.com/user-attachments/assets/01f2ca4c-1df4-4117-8e52-d0b2eb3240d2)

### terraform apply 
![terraform apply complete](https://github.com/user-attachments/assets/c383e87f-3072-4dba-b50d-17e116a3a77e)

### vpc successfully created 

![vpc created](https://github.com/user-attachments/assets/dc812359-9fd7-495e-b139-13a224324c9a)

### subnets successfully created 

![subnets created](https://github.com/user-attachments/assets/c33ed1eb-bf79-43fa-aae7-7ce573fc8277)


### Security groups successfully created
![security groups created](https://github.com/user-attachments/assets/0c32f3af-e9a8-4387-8f61-d7d2f833e97c)


### route tables successfully created 
![route tables created](https://github.com/user-attachments/assets/e53531c2-bd1f-49ab-ab8b-9dbae12810c3)



### Network access control lists successfully created 
![network acls created](https://github.com/user-attachments/assets/f17a3d9d-140e-46c7-ad54-521583610424)


### Internet gateway successfully created 

![internet gateway created](https://github.com/user-attachments/assets/60e5339a-d10a-4b90-870a-fb44b3f93db8)


### Elastic IP successfully created 

![elastic ip created](https://github.com/user-attachments/assets/b4259aaa-b706-4c4e-a32b-60cf9bf627fe)


### keypair successfully created 

![creating-keypair](https://github.com/user-attachments/assets/86be95a0-eca5-4b74-98ef-ea84cdbfa2fe)

### ec2 instances successfully created 
![2 ec2 instances created and running](https://github.com/user-attachments/assets/44f31c8a-f563-401a-b2f5-4fab6232dbf7)

 
### terraform destroy 
![terraform destroy](https://github.com/user-attachments/assets/9ad9313c-ea34-425a-855f-97538ad0eb90)



### end 
