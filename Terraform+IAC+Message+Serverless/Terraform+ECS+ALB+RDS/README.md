# Requirement

## Terraform 

- Tutorial: 
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

- Create user bia and configure aws cli profile

```sh
$ aws configure profile bia
```

# Terraform comands

## initialize terraform
```sh
terraform init
```

## Compare your real infrastructure against your configuration
```sh
terraform plan
```

## Perform the actions
```sh
terraform apply
```

## Show all of resource
```sh
terraform show
```

## List of resource
```
terraform state list
```

## Show details of resource
```sh
terraform state show <ADDRESS>
```

## Destroy all of resource
```sh
terraform destroy
```

## Destroy a specific resource
```sh
terraform destroy -target='aws_instance.bia_dev'
```

## Creating outputs
- Define all in outpus.tf

Update state of output:
```sh
terraform refresh
```
Show outputs
```sh
terraform output
```

## Import a resource by id
```sh
terraform import aws_instance.bia_dev i-064d9103fed15b231
terraform import aws_security_group.bia_dev sg-0d683cd84ba3968eb
```

## Remove a resource from state
```
terraform state rm aws_instance.bia_dev
```

## Transfer state to S3
Configuration
```sh
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
```sh
terraform init -migrate-state
```
