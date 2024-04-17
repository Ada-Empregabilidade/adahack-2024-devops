/**
* Esse arquivo configura as variaveis para o ambiente de produção
*/
module "Production" {
  source = "../../infra"
  region = "us-west-2"
  name = "production"
  description = "application-for-production"
  enviroment_beanstalk_name = "enviroment-for-production"
  type_instance = "t2.micro"
  max_size = 5
}