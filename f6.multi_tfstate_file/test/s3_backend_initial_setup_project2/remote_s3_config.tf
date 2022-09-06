# Provider Details
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Kapil\\.aws\\credentials"]
  profile                  = "default"
}

# 1. S3 bucket creation and object lock configuration
resource "aws_s3_bucket" "bucket_lock" {
  bucket        = "31-08-test-terraform-state" # if bucket not present will create one
  force_destroy = true

  # object_lock_enabled = true # this enables bucket versioning by default irrespective of retention policy
  tags = {
    "Project" = "S3 Remote Terraform State Store"
  }
}

## the below bucket_lock_config is optional
# resource "aws_s3_bucket_object_lock_configuration" "bucket_lock_config" {
#   bucket = aws_s3_bucket.bucket_lock.bucket

#   rule {
#     default_retention {
#       mode = "GOVERNANCE" # if COMPLIANCE used Even root user can't delete the file until its retention period
#       days = 1
#     }
#   }
# }

# 2. DynamoDB configuration
resource "aws_dynamodb_table" "terraform-lock" {
  name           = "db_lock_table_test"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}


output "vpc_id" {
  value = aws_dynamodb_table.terraform-lock.id
}