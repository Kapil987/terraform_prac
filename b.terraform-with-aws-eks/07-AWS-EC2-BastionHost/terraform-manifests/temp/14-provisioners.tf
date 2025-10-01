resource "null_resource" "copy_ec2_key" {
  connection {
    type = "ssh"
    host = aws_eip.for_bastion1.public_ip
    user = "ubuntu"
    password = ""
    private_key = file("../private-key/aws6-nvirginia.pem")
  }

  provisioner "file" {
    source = "../private-key/aws6-nvirginia.pem"
    destination = "/tmp/aws6-nvirginia.pem"
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod 400 /tmp/aws6-nvirginia.pem"
     ]
  }

  provisioner "local-exec" {
    command = "echo vpc created on `date` and VPC IS: ${module.vpc.default_vpc_id} >> vpc_creation.txt"
    working_dir = "local-exec-output-files"
    
  }

  depends_on = [ module.ec2_public ]
}