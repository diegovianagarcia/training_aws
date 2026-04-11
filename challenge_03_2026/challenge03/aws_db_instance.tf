resource "aws_db_instance" "bia" {
  allocated_storage                     = 20
  allow_major_version_upgrade           = null
  apply_immediately                     = null
  auto_minor_version_upgrade            = true
  backup_retention_period               = 0
  backup_window                         = "04:04-04:34"
  ca_cert_identifier                    = "rds-ca-rsa2048-g1"
  copy_tags_to_snapshot                 = true
  custom_iam_instance_profile           = null
  customer_owned_ip_enabled             = false
  delete_automated_backups              = true
  deletion_protection                   = false
  domain                                = null
  domain_iam_role_name                  = null
  enabled_cloudwatch_logs_exports       = []
  engine                                = "postgres"
  engine_version                        = "17.6"
  final_snapshot_identifier             = null
  iam_database_authentication_enabled   = false
  identifier                            = "bia"
  instance_class                        = "db.t3.micro"
  iops                                  = 0
  kms_key_id                            = "arn:aws:kms:us-east-1:095893258509:key/6497ac63-8045-4095-a23d-2c4af4a01cdc"
  license_model                         = "postgresql-license"
  maintenance_window                    = "sun:03:24-sun:03:54"
  manage_master_user_password           = true
  max_allocated_storage                 = 0
  monitoring_interval                   = 0
  multi_az                              = false
  network_type                          = "IPV4"
  option_group_name                     = "default:postgres-17"
  parameter_group_name                  = "default.postgres17"
  password                              = null
  performance_insights_enabled          = false
  performance_insights_retention_period = 0
  port                                  = 5432
  publicly_accessible                   = false
  replicate_source_db                   = null
  skip_final_snapshot                   = true
  storage_encrypted                     = true
  storage_throughput                    = 0
  storage_type                          = "gp2"
  tags                                  = {}
  tags_all                              = {}
  username                              = "postgres"
  vpc_security_group_ids                = [aws_security_group.bia_db.id]
  db_subnet_group_name                  = aws_db_subnet_group.bia.name
}

resource "aws_db_subnet_group" "bia" {
  name       = "bia-db-subnet-group"
  subnet_ids = [local.subnet_zona_a, local.subnet_zona_b]
  tags = {
    name = "bia-db-subnet-group"
  }
}
