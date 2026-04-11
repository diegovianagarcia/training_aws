output "instance_id" {
  value = aws_instance.bia_dev.id
}

output "instance_type" {
  value = aws_instance.bia_dev.instance_type
}

output "instance_security_groups" {
  value = aws_instance.bia_dev.security_groups
}

output "rds_endpoint" {
  value = aws_db_instance.bia.endpoint
}

output "ecr_repository_url" {
  value = aws_ecr_repository.bia.repository_url
}

output "rds_secret_name" {
  description = "Nome do segredo associado ao RDS"
  value       = data.aws_secretsmanager_secret.bia_db.name
}
