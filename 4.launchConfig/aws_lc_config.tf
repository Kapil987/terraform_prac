data "aws_ami" "amazon_linux2" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_id_use]
  }

  owners = ["self"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {
  name          = "web_config_1"
  image_id      = data.aws_ami.amazon_linux2.id
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
  user_data = file("init.sh")
}

resource "aws_autoscaling_group" "bar" {
  name                 = "web_asg_1"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 1
  max_size             = 2

  lifecycle {
    create_before_destroy = true
  }

}
