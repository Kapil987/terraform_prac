# Retrieve aws autoscaling groups created during cluster deployement
/*
data "aws_autoscaling_groups" "groups" {
  filter {
    name   = "tag:eks:cluster-name"
    values = ["ed-eks-01"]
  }
  depends_on = [
    aws_eks_node_group.prod,
    aws_eks_node_group.dev
  ]

#   filter {
#     name   = "tag-key"
#     values = ["Environment"]
#   }
}

output "auto-scaling-group-name" {
  value = data.aws_autoscaling_groups.groups.names
}

*/