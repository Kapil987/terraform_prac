terraform {
  backend "s3" {
    bucket = "31-08-test-terraform-state"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table =  "db_lock_table_test" # variables are not allowed here
  }
}

