# Provider Details
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Kapil\\.aws\\credentials"]
  profile = "default"
}

## Create S3 Bucket and DynamoDB table to store state and state lock., Old syntax
resource "aws_s3_bucket" "bucket" {
    bucket = "kapil987-terraform-state"

    object_lock_configuration {
        object_lock_enabled = "Enabled"
    }
    tags = {
        Name = "S3 Remote Terraform State Store"
    }
}

## New Syntax S3 setup
# resource "aws_s3_bucket" "bucket_lock" {
#   bucket        = "kapil987-terraform-state"
#   force_destroy = true

#   object_lock_enabled = true # this enables bucket versioning by default irrespective of retention policy
#   tags = {
#     "Project" = "S3 Remote Terraform State Store"
#   }
# }

# resource "aws_s3_bucket_object_lock_configuration" "bucket_lock_config" {
#   bucket = aws_s3_bucket.bucket_lock.bucket

#   rule {
#     default_retention {
#       mode = "GOVERNANCE" # if COMPLIANCE used Even root user can't delete the file until its retention period
#       days = 1
#     }
#   }
# }

resource "aws_dynamodb_table" "terraform-lock" {
  name           = "db_lock_table"
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
