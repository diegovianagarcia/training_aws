# terraform {
#   backend "s3" {
#     bucket  = "diego-bia-terraform"
#     key     = "terraform.tfstate"
#     region  = "us-east-1"
#     profile = "bia"
#   }
# }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
