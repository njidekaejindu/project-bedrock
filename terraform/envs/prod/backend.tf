terraform {
  backend "s3" {
    bucket         = "bedrock-tfstate-541801281384-025-1181"
    key            = "project-bedrock/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "bedrock-terraform-locks"
    encrypt        = true
  }
}
