/**
* Esse arquivo contém a configuração do recurso de IAM Role que será utilizado pelo Elastic Beanstalk.
* Ele também contém a configuração de uma política de IAM para a Role.
* Ele também contém a configuração de um perfil de instância IAM que será utilizado pelo Elastic Beanstalk.
*/

resource "aws_iam_role" "beanstalk_instance_role" {
  name = "aws-elasticbeanstalk-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "aws-elasticbeanstalk_ec2_policy" {
    name = "aws-elasticbeanstalk-ec2-policy"
    role = aws_iam_role.beanstalk_instance_role.id
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = [
                    "cloudwatch:PutMetricData",
                    "ds:CreateComputer",
                    "ds:DescribeDirectories",
                    "ec2:DescribeInstancesStatus",
                    "logs:*",
                    "ssm:*",
                    "ec2messages:*",
                    "ecr:GetAuthorizationToken",
                    "ecr:BatchCheckLayerAvailability",
                    "ecr:GetDownloadUrlForLayer",
                    "ecr:GetRepositoryPolicy",
                    "ecr:DescribeRepositories",
                    "ecr:ListImages",
                    "ecr:DescribeImages",
                    "ecr:BatchGetImage",
                    "s3:*"
                ],
                Resource = "*"
            }
        ]
    })
}

resource "aws_iam_instance_profile" "aws-elasticbeanstalk_ec2_profile" {
  name = "aws-elasticbeanstalk-ec2-profile"
  role = aws_iam_role.beanstalk_instance_role.name
}