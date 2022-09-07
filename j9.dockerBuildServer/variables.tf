variable "ami_id_amazon" {
  description = "ami-id"
}

variable "buildSeverName" {
  description = "ami-id"
}

variable "az1" {
  description = "availibilityzone"
}

# Based on count zones will change
variable "avaialability_zones" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = list
  default = ["us-east-1a","us-east-1b", "us-east-1c"]
}

variable "user" {
  description = "availabilityzone"
  type = string
  default = "ec2-user"
  sensitive = true
}