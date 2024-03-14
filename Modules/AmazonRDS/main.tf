data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "../VPC"
  #version = "2.77.0"

  name                 = "tessolve"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "tessolve_rds" {
  name       = "tessolve_rds"
  subnet_ids = module.vpc.aws_public_subnet

  tags = {
    Name = "tessolve-subnet"
  }
}

resource "aws_security_group" "rds" {
  name   = "tessolve_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tessolve_rds"
  }
}

resource "aws_db_parameter_group" "tessolve_rds" {
  name   = "tessolve_rds"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "tessolve_rds" {
  identifier             = "tessolve_rds"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "14.1"
  username               = "tessolve"
  password               = "Testdb@12345"
  db_subnet_group_name   = aws_db_subnet_group.tessolve_rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.tessolve_rds.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
