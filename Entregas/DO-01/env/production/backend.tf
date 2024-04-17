/**
* Esse arquivo configura o backend para armazenar o estado em um bucket do S3.
*/
terraform {
  backend "s3" {
  }
}