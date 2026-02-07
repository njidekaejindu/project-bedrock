variable "project_name" {
  type    = string
  default = "project-bedrock"
}

variable "vpc_name_tag" {
  type    = string
  default = "project-bedrock-vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "assets_bucket_name" {
  description = "S3 bucket for assets uploads"
  type        = string
  default     = "bedrock-assets-alt-soe-025-1181"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "catalog_db_password" {
  description = "Password for catalog RDS MySQL"
  type        = string
  sensitive   = true
}

variable "orders_db_password" {
  description = "Password for orders RDS PostgreSQL"
  type        = string
  sensitive   = true
}
