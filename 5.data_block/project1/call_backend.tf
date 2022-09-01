terraform {
  backend "s3" {
    bucket = "30-08-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table =  "db_lock_table" # variables are not allowed here
  }
}

