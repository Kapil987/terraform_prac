resource "aws_iam_instance_profile" "ec2_bastion_profile" {
  name = "ec2_bastion_profile"
  role = aws_iam_role.ec2_bastion_role.name
}

data "aws_iam_policy_document" "assume_role_for_ec2" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_bastion_role" {
  name               = "ec2_bastion_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_for_ec2.json
}

resource "aws_iam_role_policy_attachment" "ec2_bastion_admin" {
  role       = aws_iam_role.ec2_bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
