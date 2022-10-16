resource "aws_eks_node_group" "prod" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "prod"
  node_role_arn   = aws_iam_role.worker.arn
  capacity_type   = "ON_DEMAND"
  disk_size       = "20"
  instance_types  = ["t3.medium"]
  remote_access {
    ec2_ssh_key               = "vinod-eks"
    source_security_group_ids = [aws_security_group.node.id]
  }

  subnet_ids = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]
  # subnet_ids = [aws_subnet.pub_sub1.id]

  # taint {
  #   key    = "frontend"
  #   value  = "yes"
  #   effect = "NO_SCHEDULE"
  # }


  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_subnet.pub_sub1,
    aws_subnet.pub_sub2,
  ]
}

resource "aws_eks_node_group" "dev" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "dev"
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]
  # subnet_ids      = [aws_subnet.pub_sub2.id]
  instance_types  = ["t3.medium"]

  remote_access {
    ec2_ssh_key               = "vinod-eks"
    source_security_group_ids = [aws_security_group.node.id]
  }

# the below works at kubernetes level not at aws level
#  labels = tomap({ env = "dev" })

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]

  # the below is un-supported
  # tags {
  #   key   = "Name"
  #   value = "eks-dev"

  #   propagate_at_launch = true
  # }

  # the below has no visible effect
  # tags = {
  #   Name = "eks-dev-tf"
  # }

}

# Nodes were made in the same az to added only one subnet in each node group
# sub1 us-east-1a, sub2 us-east-1b
