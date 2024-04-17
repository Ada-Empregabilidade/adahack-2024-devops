/**
* Esse arquivo define as variáveis que serão utilizadas no projeto
*/

variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "enviroment_beanstalk_name" {
  type = string
}

variable "type_instance" {
  type = string
}

variable "max_size" {
  type = number
}