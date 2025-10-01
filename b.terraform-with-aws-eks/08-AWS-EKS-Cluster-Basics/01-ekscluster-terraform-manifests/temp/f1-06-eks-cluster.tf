resource "aws_eks_cluster" "eks_demo" {
  name = "${local.name}-${var.cluster_name}"
  # environment = "dev"
  # business_divsion = "HR"

  # access_config {
  #   authentication_mode = "API"
  # }

  role_arn = aws_iam_role.eks_master_role.arn
  # version  = "1.32"
  version = var.cluster_version

  # where your EKS network interfaces will be present
  vpc_config {
    subnet_ids = module.vpc.public_subnets
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access = var.cluster_endpoint_public_access
    public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }
  # https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  # Enable EKS Cluster Control Plane logging
  enabled_cluster_log_types = ["api","audit","authenticator", "controllerManager","scheduler" ]

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy, aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController
  ]
}
