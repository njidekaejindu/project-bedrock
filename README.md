# Project Bedrock — InnovateMart EKS Deployment

Terraform IaC + GitHub Actions CI/CD to provision AWS EKS and deploy the retail-store-sample-app.

Region: us-east-1
Cluster: project-bedrock-cluster
VPC Tag Name: project-bedrock-vpc
Namespace: retail-app
Project Tag: Bedrock





Project Bedrock is a production-style AWS infrastructure and platform deployment built with Terraform, Amazon EKS, and GitHub Actions.



The project demonstrates Infrastructure as Code, secure CI/CD automation, Kubernetes RBAC, observability, and event-driven serverless integration.





Architecture Overview



\- Custom VPC with public and private subnets across two AZs

\- Amazon EKS cluster hosting the retail-store-sample application

\- Application Load Balancer (ALB) exposed via Kubernetes Ingress

\- Managed data services (RDS) for application persistence

\- Centralized logging to Amazon CloudWatch

\- Event-driven S3 → Lambda asset processing flow



A full architecture diagram and explanation are provided in the submission document.



CI/CD Pipeline



The project uses GitHub Actions for automated infrastructure deployment:



\- Pull Request to `main` → `terraform plan`

\- Merge to `main` → `terraform apply`

\- Terraform state is stored remotely in Amazon S3 with DynamoDB locking



AWS credentials are securely stored using GitHub repository secrets.





Deployment (Local)



```bash

cd terraform/envs/prod

terraform init

terraform plan

terraform apply



