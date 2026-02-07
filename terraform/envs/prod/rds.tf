############################
# RDS Subnet Group
############################
resource "aws_db_subnet_group" "bedrock" {
  name       = "${var.project_name}-rds-subnets"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Project = "Bedrock"
  }
}

############################
# RDS Security Group
############################
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow DB access from EKS nodes"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "MySQL from EKS nodes"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_cluster_sg.id]
  }

  ingress {
    description     = "Postgres from EKS nodes"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_cluster_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "Bedrock"
  }
}

############################
# MySQL (Catalog)
############################
resource "aws_db_instance" "catalog_mysql" {
  identifier        = "${var.project_name}-catalog-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "catalog"
  username = "catalog"
  password = var.catalog_db_password

  db_subnet_group_name   = aws_db_subnet_group.bedrock.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Project = "Bedrock"
  }
}

############################
# PostgreSQL (Orders)
############################
resource "aws_db_instance" "orders_postgres" {
  identifier        = "${var.project_name}-orders-postgres"
  engine            = "postgres"
  engine_version    = "16"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "orders"
  username = "orders"
  password = var.orders_db_password

  db_subnet_group_name   = aws_db_subnet_group.bedrock.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Project = "Bedrock"
  }
}

############################
# Outputs
############################
output "catalog_rds_endpoint" {
  description = "RDS endpoint for Catalog MySQL"
  value       = aws_db_instance.catalog_mysql.address
}

output "orders_rds_endpoint" {
  description = "RDS endpoint for Orders PostgreSQL"
  value       = aws_db_instance.orders_postgres.address
}
