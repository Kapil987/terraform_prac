data "aws_availability_zones" "list_of_azs_from_data_block" {
  state = "available"
  # exclude_names = ["us-east-1a","us-east-1b"]
}
