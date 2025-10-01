resource "aws_eks_node_group" "eks_nodegroup_public" {
  cluster_name    = aws_eks_cluster.eks_demo.name
  node_group_name = "${local.name}-eks-nodegroup-public"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.vpc.public_subnets
  version         = var.cluster_version
  # https://docs.aws.amazon.com/eks/latest/APIReference/API_Nodegroup.html#AmazonEKS-Type-Nodegroup-amiType
  ami_type        = "AL2023_x86_64_STANDARD"
  capacity_type   = "ON_DEMAND"
  disk_size       = 20

  instance_types = ["t3.medium"]
  remote_access {
    ec2_ssh_key = var.instance_keypair
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ]

  # tags = local.common_tags
  tags = merge(
    local.common_tags,
    {
      Name = "Public Node Group"
    }
  )
}
