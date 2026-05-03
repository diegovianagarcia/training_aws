# RDS and SQL Server

Goals:
- Learn how to run SQL Server with Docker on AWS and restore a backup to RDS. 


## 1. Restore backup to docker container SQL Server inside the EC2 instance 

### Run image SQl Server with docker inside the ec2 instance
```
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<password>" -e "MSSQL_PID=Evaluation" -p 1433:1433  --name sql2025 --hostname sql2025 -d mcr.microsoft.com/mssql/server:2025-latest
```

### Download the Advance Work

```shell
wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak
```

### Copy backup file to container
```shell
docker cp AdventureWorks2019.bak <container_id>:/var/opt/mssql/data/
```

### Create a ssh tunel/port forwarding to secure connection on EC2 instance
```shell
ssh -f -N -i <pem_file> -L 1436:<ec2_private_ip>:1433 ec2-user@<ec2_public_ip>
```

### Restore the AdventureWorks database

```sql
RESTORE FILELISTONLY FROM DISK = 'AdventureWorks2019.bak';

RESTORE DATABASE AdventureWorks
FROM DISK = 'AdventureWorks2019.bak'
WITH
	MOVE 'AdventureWorks2019' TO '/var/opt/mssql/data/AdventureWorks2019.mdf',
	MOVE 'AdventureWorks2019_log' TO '/var/opt/mssql/data/AdventureWorks2019_log.ldf';
```
## 2. Restore backup to RDS SQL Server

### Create a RDS SQl Server

### Create a role for the EC2 instance to have permission in S3.
- Policy: AmazonS3FullAccess
- Trust relationship
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```
### Create a role for option group to have permission make backup and restore from s3
Custom policy
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::<name_backut_s3>"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObjectAttributes",
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload"
            ],
            "Resource": "arn:aws:s3:::<name_backut_s3>/*"
        }
    ]
}
```
Trust relationship
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "rds.amazonaws.com"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "<aws_count_id>",
                    "aws:SourceArn": [
                        "arn:aws:rds:us-east-1:<aws_count_id>:db:<database_name>",
                        "arn:aws:rds:us-east-1:<aws_count_id>:og:<option_group_name>"
                    ]
                }
            }
        }
    ]
}
```

### Copy backup file to S3
```shell
aws s3 cp AdvanceWorks2019.bak s3://<bucket_name>
```

### Create a ssh tunel/port forwarding to secure connection on RDS
Example

```shell
ssh -f -N -i formacao.pem -L 1437:mssql-sever.co70gok8o718.us-east-1.rds.amazonaws.com:1433 ec2-user@ec2-54-204-82-156.compute-1.amazonaws.com

```

### Execute script SQL to restore backup
```sql
exec msdb.dbo.rds_restore_database
@restore_db_name='AdventureWorks',
@s3_arn_to_restore_from='arn:aws:s3:::<bucket_name>/AdventureWorks2019.bak';
```

### Finished !!!

### To backup the database
```sql
exec msdb.dbo.rds_backup_database
@restore_db_name='AdventureWorks',
@s3_arn_to_restore_from='arn:aws:s3:::<bucket_name>/AdventureWorks2019_custom.bak'
@number_of_files=1;
```
