# to execute command at in local computer
resource "null_resource" "execute-command" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${aws_eks_cluster.eks.name} --region ${var.region}"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [
    aws_eks_node_group.dev,
    aws_eks_node_group.prod
  ]
}


  # provisioner "local-exec" {
  #   when    = "destroy"
  #   command = "rm hosts"
  # }