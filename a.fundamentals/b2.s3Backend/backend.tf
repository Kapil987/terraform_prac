# Backend Block S3 DynamoDB
terraform {
  backend "s3" {
    bucket = "kapil987-terraform-state"
    key    = "learnings/dev/terraform.tfstate"
    region = "us-east-1" # this has to be static, variables are not allowed here
    dynamodb_table =  "db_lock_table" # variables are not allowed here
  }
}