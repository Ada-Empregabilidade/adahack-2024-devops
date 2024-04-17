/**
* Esse arquivo configura a aplicação utilizando Elastic Beanstalk
* Ele cria uma aplicação com o nome e descrição.
* Ele também cria um ambiente para a aplicação.
*/

resource "aws_elastic_beanstalk_application" "zoo_app" {
  name = var.name
  description = var.description
}

resource "aws_elastic_beanstalk_environment" "enviroment_beanstalk" {
  name = var.enviroment_beanstalk_name
  application = aws_elastic_beanstalk_application.zoo_app.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.3.0 running Docker"
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "InstanceType"
        value = var.type_instance
    }
    setting {
        namespace = "aws:autoscaling:asg"
        name = "MaxSize"
        value = var.max_size
    }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "IamInstanceProfile"
        value = aws_iam_instance_profile.aws-elasticbeanstalk_ec2_profile.name
    }
}

resource "aws_elastic_beanstalk_application_version" "default" {
  depends_on = [ aws_elastic_beanstalk_environment.enviroment_beanstalk, aws_elastic_beanstalk_application.zoo_app, aws_s3_object.docker ]
  name = var.enviroment_beanstalk_name
  application = var.name
  description = var.description
  bucket = aws_s3_bucket.beanstalk_bucket.id
  key = aws_s3_object.docker.id
}