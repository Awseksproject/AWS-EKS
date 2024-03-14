

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
}

variable "aws_public_subnet" {}
variable "vpc_id" {}
