resource "aws_iam_user_policy" "bia_terraform_policy" {
  name = "bia-terraform-policy"
  user = "bia"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:*",
          "ecs:*",
          "ec2:*",
          "rds:*",
          "iam:*",
          "logs:*",
          "autoscaling:*",
          "elasticloadbalancing:*",
          "s3:*",
          "secretsmanager:*",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
          "kms:DescribeKey",
          "kms:GenerateDataKey",
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:ReEncrypt*"
        ]
        Resource = "*"
      }
    ]
  })
}
