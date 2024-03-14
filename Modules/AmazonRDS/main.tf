data "aws_availability_zones" "available" {}



resource "aws_db_subnet_group" "tessolverds" {
  name       = "tessolverds"
  subnet_ids = var.aws_public_subnet

  tags = {
    Name = "tessolve-subnet"
  }
}

resource "aws_security_group" "rds" {
  name   = "tessolverds"
  vpc_id = var.vpc_id

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
    Name = "tessolverds"
  }
}

resource "aws_db_parameter_group" "tessolverds" {
  name   = "tessolverds"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "tessolverds" {
  identifier             = "tessolverds"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "16.1"
  username               = "tessolve"
  db_password            = "test@db1512"
  db_subnet_group_name   = aws_db_subnet_group.tessolverds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.tessolverds.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
