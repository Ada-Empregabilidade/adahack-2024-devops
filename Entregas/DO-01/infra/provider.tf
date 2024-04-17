/**
* Esse arquivo contém a configuração do provider que será utilizado pelo Terraform.
* Ele também contém a configuração de um recurso de instância EC2.
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}