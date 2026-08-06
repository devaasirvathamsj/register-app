resource "aws_iam_role" "ssm_role" {
    name = var.ssm_role_name
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
  
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy_attachment" {
    role       = aws_iam_role.ssm_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
    name = "${var.ssm_role_name}-instance-profile"
    role = aws_iam_role.ssm_role.name
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  count      = var.attach_ecr_policy ? 1 : 0
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}