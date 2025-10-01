resource "aws_iam_role" "eks_master_role" {
  name = "${local.name}-eks-master-role"
  # https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html
  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  POLICY
}

# Associate IAM Policy to IAM role
resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_master_role.name

}
# The policy allows the role to manage network interfaces, their private IP addresses, and their attachment and detachment to and from network instances.
resource "aws_iam_role_policy_attachment" "eks-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role = aws_iam_role.eks_master_role.name
}
