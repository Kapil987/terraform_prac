# default file name is terraform.tfvars, if changed then you need to supply this file in cmd
subnet_prefix = [{cidr_block = "10.0.1.0/24", name= "web-pub-subnet1"},{cidr_block = "10.0.2.0/24", name= "web-private-subnet2"}]
ami_id = "ami-037ff6453f0855c46"