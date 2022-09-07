# Create EC2 
resource "aws_instance" "web" {
  ami                         = var.ami_id_amazon
  instance_type               = "t2.micro"
  availability_zone           = element(var.avaialability_zones, count.index)
  key_name                    = "dpt06"
  vpc_security_group_ids      = [aws_security_group.allow_web.id]
  associate_public_ip_address = true
  count                       = 1

  tags = {
    Name = "${var.buildSeverName[0]}${count.index}"
  }

  user_data = file("init.sh")

  # Key and local file will not get deleted, when EC2 is destroyed
  provisioner "file" {
    source      = "C:\\Learnings\\terraform_prac\\j9.dockerBuildServer\\Dockerfile"
    destination = "/tmp/Dockerfile"

  }
  connection {
    type        = "ssh"
    user        = var.user
    private_key = file("C:\\Users\\Kapil\\Downloads\\dpt06.pem")
    # host        = "${self.private_ip}"
    host = self.public_ip

  }
}
