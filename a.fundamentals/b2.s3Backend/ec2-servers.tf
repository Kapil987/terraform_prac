# 9. Create EC2 
resource "aws_instance" "web" {
  ami               = "ami-072aa37bbd1554d3c"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a" # Hardcoded to avoid aws randomly creates in any AZ
  key_name          = "dpt06"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.webnic.id
  }
  tags = {
    Name = "terraform-test"
  }

  user_data = "${file("initial_boot.sh")}"
}