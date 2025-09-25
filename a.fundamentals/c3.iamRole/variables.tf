variable "subnet_prefix" {
  description = "cidr block for subnets"
  type = list
}

variable "subnet_az" {
  description = "define availabilty zone"
  type = list
}

variable "region_dev" {
  description = "define availabilty zone"
  default = "us-east-1"
  type = string
  
}