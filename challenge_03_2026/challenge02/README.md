# Requirement

## Terraform 

- Tutorial: 
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

- Create user bia and configure aws cli profile
```shell
aws cli configure profile bia
```

# Terraform comands

## initialize terraform
```shell
terraform init
```
## Compare your real infrastructure against your configuration
```shell
terraform plan
```
## Perform the actions
```shell
terraform apply
```
## Show all of resource
```shell
terraform show
```
## List of resource
```shell
terraform state list
```
## Show details of resource
```shell
terraform state show <ADDRESS>
```
## Destroy all of resource
```shell
terraform destroy
```

## Destroy a specific resource
```shell
terraform destroy -target='aws_instance.bia_dev'
```

## Creating outputs
- Define all in outpus.tf

Update state of output:
```shell
terraform refresh
```
Show outputs
```shell
terraform output
```

## Import a resource by id
```shell
terraform import aws_instance.bia_dev i-064d9103fed15b231
terraform import aws_security_group.bia_dev sg-0d683cd84ba3968eb
```

## import in block
Create a `<file_name>.tf`
```terraform
import {
  id = "role-acesso-ssm"
  to = aws_iam_role.role_acesso_ssm
}

import {
  id = "role-acesso-ssm"
  to = aws_iam_instance_profile.role_acesso_ssm
}
```
Appying the import
```shell
terraform apply
```

## Generate the plan into file
```shell
terraform plan -generate-config-out=out_iam.tf
```

## Remove a resource from state
```shell
terraform state rm aws_instance.bia_dev
```

## Transfer state to S3
Configuration
```terraform
terraform {
    backend "s3" {
        bucket = "diego-bia-terraform"
        key    = "./terraform.tfstate"
        region = "us-east-1"
        profile = "bia"
    }
}
```

Add policy to user
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::diego-bia-terraform",
            "Condition": {
                "StringEquals": {
                    "s3:prefix": "diego-bia-terraform/terraform.tfstate"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::diego-bia-terraform/terraform.tfstate"
            ]
        }
    ]
}
```

To migrate the state
```shell
terraform init -migrate-state
```
