# for now using the below block two times, improvement can be made such that we can pass a list instead of dev and prod

/* # the below can be ran only after the asg group is created even depends upon will not work here

## Tagging for Dev EC-2
resource "aws_autoscaling_group_tag" "dev-tagging" {
  for_each = toset(
    [for asg in flatten(
      [for resources in aws_eks_node_group.dev.resources : resources.autoscaling_groups]
    ) : asg.name]
  )

  autoscaling_group_name = each.value

  tag {
    key   = "Name"
    value = "eks-dev"

    propagate_at_launch = true
  }
  depends_on = [
    aws_eks_node_group.dev
  ]

}

## Tagging for Prod EC-2
resource "aws_autoscaling_group_tag" "prod-tagging" {
  for_each = toset(
    [for asg in flatten(
      [for resources in aws_eks_node_group.prod.resources : resources.autoscaling_groups]
    ) : asg.name]
  )

  autoscaling_group_name = each.value

  tag {
    key   = "Name"
    value = "eks-prod"

    propagate_at_launch = true
  }
  depends_on = [
    aws_eks_node_group.prod
  ]

}

*/