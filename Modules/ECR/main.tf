resource "aws_ecr_repository" "tessolve" {
name = var.ecrname
image_tag_mutability = "MUTABLE"
image_scanning_configuration {
scan_on_push = true
}
}
