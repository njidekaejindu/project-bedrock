terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "bedrock-tfstate-alt-soe-025-1181-new"
    key            = "project-bedrock/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "bedrock-tf-locks-alt-soe-025-1181-new"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
