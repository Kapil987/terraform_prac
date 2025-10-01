resource "null_resource" "copy_ec2_key" {
  connection {
    type = "ssh"
    host = aws_eip.for_bastion1.public_ip
    user = "ubuntu"
    # password = ""
    private_key = file("../private-key/${var.instance_keypair}.pem")
  }

  provisioner "file" {
    source = "../private-key/${var.instance_keypair}.pem"
    destination = "/home/ubuntu/${var.instance_keypair}.pem"
  }

  provisioner "remote-exec" {
    inline = [ 
      # "sudo chmod 400 /home/ubuntu/${var.instance_keypair}.pem"
      "aws eks --region ${var.aws_region} update-kubeconfig --name ${local.eks_cluster_name}"
     ]
  }

  provisioner "local-exec" {
    command = "echo vpc created on `date` and VPC is: ${module.vpc.vpc_id} >> vpc_creation.txt"
    working_dir = "../local-exec-output-files"
    
  }

  depends_on = [ module.ec2_public ]
}