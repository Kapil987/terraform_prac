terraform {
  backend "s3" {
    bucket = "31-08-dev-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table =  "db_lock_table" # variables are not allowed here
  }
}

