/**
* Esse arquivo faz a criação de um repositório ECR
*/

resource "aws_ecr_repository" "repository" {
  name = var.name
}