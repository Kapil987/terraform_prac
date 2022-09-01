provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Kapil\\.aws\\credentials"]
  profile                  = "default"
}
# Create EC2 
resource "aws_instance" "web" {
  ami                    = data.aws_ami.test_ami.id
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a" # Hardcoded to avoid aws randomly creates in any AZ
  key_name               = "dpt06"
  subnet_id              = data.terraform_remote_state.import_subnet1.outputs.sub1_id
  vpc_security_group_ids = [data.terraform_remote_state.import_sg.outputs.sg_id]
  tags = {
    Name = "terraform-test"
  }
}
