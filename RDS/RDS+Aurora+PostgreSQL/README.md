# RDS + Aurora PostgreSQL

Goals:
- Learn how to migrate PostgreSQL Server from RDS to Aurora Serverless v2

Steps
- launch infra with Terraform+ECS+ALB+RDS
- Create database Aurora Serverless v2 with minimum capacity
- Connect to ec2 instance named bia-dev-tf and settings de environment in .pgpass and backup_restore.sh
- Execute backup_restore.sh
