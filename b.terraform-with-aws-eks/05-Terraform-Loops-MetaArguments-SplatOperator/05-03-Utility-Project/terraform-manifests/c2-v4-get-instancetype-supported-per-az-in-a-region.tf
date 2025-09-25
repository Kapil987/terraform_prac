data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ec2_instance_type_offerings" "my_ins_type3" {
  # for each accespt only map or set
  for_each = toset(data.aws_availability_zones.available.names)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}

output "available_azs1" {
  value = data.aws_availability_zones.available.names
}

output "ec2_available_regions" {
  # value = data.aws_ec2_instance_type_offerings.my_ins_type3
  # value = [for types in data.aws_ec2_instance_type_offerings.my_ins_type3: types.instance_types]
  # value = [for types in data.aws_ec2_instance_type_offerings.my_ins_type3: types.instance_types]
  # keys({
  # for az, types in data.aws_ec2_instance_type_offerings.my_ins_type3: az => types.instance_types if length(types.instance_types) !=0
  # } ) 
  #
  value = {
    for az, types in data.aws_ec2_instance_type_offerings.my_ins_type3: az => types.instance_types if length(types.instance_types) !=0
    }
}


output "ec2_available_regions_keys" {
  value = keys({
  for az, types in data.aws_ec2_instance_type_offerings.my_ins_type3: az => types.instance_types if length(types.instance_types) !=0
  } ) 
}