data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "30-08-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
