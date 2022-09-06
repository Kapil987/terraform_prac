resource "aws_instance" "web1234" {
  ami           = "ami-072aa37bbd1554d3c"
  # instance_type = "t2.micro"
  instance_type = var.instance_type
}

variable "instance_type" {
  type = string
}


