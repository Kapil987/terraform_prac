# default file name is terraform.tfvars, if changed then you need to supply this file in cmd
# terraform plan --var-file=example.tfvars
subnet_prefix = [{cidr_block = "10.0.1.0/24", name= "web-pub-subnet1"},{cidr_block = "10.0.2.0/24", name= "web-pub-subnet2"}]
subnet_az = ["us-east-1a","us-east-1b"]
region_dev = "us-east-1"