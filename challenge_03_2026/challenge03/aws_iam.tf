resource "aws_iam_instance_profile" "role_acesso_ssm" {
  name     = "role-acesso-ssm"
  path     = "/"
  role     = aws_iam_role.role_acesso_ssm.name
  tags     = {}
  tags_all = {}
}

resource "aws_iam_role" "role_acesso_ssm" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = "Allows EC2 instances to call AWS services on your behalf."
  force_detach_policies = false
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    aws_iam_policy.get_secret_bia_db.arn
  ]
  max_session_duration = 3600
  name                 = "role-acesso-ssm"
  path                 = "/"
  permissions_boundary = null
  tags                 = {}
  tags_all             = {}
}
