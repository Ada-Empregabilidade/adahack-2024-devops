# Nome dos integrantes

<<<<<<< HEAD
# Nome do Projeto

# Proposta 
=======
- Danilo Argolo [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/danargolo)
- Diego Lopes [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/Diegox0301)
- Felipe Clemente [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/felipemike)
- Gracielly Ribeiro [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/GraciellySRibeiro)
- Gustavo Pinheiro [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/Gustavopnhro)
- Joniel Oliveira [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/JonielOliveira)
- Madson Rocha [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/madsonsd)
- Marco Tulio [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/MarcoTulioFM)

# Nome do Projeto

# Proposta 
![Diagrama ci_cd drawio](https://github.com/Hackaton-Ada/adahack-2024-devops/assets/132016875/23926dfc-78ec-4112-adb1-4bd7828351cf)


# Criação de usuários no IAM
Foram criados oito usuários no IAM, cada um com acesso específico ao EC2 e ao CloudFormation.

 Foi acessando o Console da AWS no serviço IAM. Lá foi criado um grupo chamado "CloudAdmins" e associou as políticas "AmazonEC2FullAccess" e "AWSCloudFormationFullAccess" a esse grupo.

 Em seguida foram criados usuários, garantindo que eles tivessem acesso programático para usar a AWS CLI e as chaves de acesso correspondentes, eles foram adicionados ao grupo "CloudAdmins", garantindo que todos compartilhassem as mesmas permissões.

 Depois que os usuários foram criados, foi dada as credenciais a cada membro, com isso, a equipe pôde colaborar de forma mais eficiente, implantando instâncias EC2 e gerenciando recursos com o CloudFormation

# Templates CloudFormation

## 1. Ambiente de Desenvolvimento
Template CloudFormation projetado para implantar um aplicativo em um ambiente de desenvolvimento na AWS. Ele inclui a criação de uma VPC, subnets públicas, um Internet Gateway, uma tabela de roteamento pública, uma instância EC2 e um grupo de segurança para as instância.

### Recursos
- Virtual Private Cloud (VPC):
    - Subnets Públicas: Duas subnets públicas para hospedar a instância EC2 e outros recursos públicos;

    - Internet Gateway: Um gateway para permitir a comunicação entre a VPC e a Internet;

    - Tabela de Roteamento Pública: Uma tabela de roteamento para rotear o tráfego de saída para o Internet Gateway.


- Grupo de Segurança: Um grupo de segurança para controlar o tráfego de rede para a instância EC2;

- Instância EC2: Instância que hospedará o ambiente de desenvolvimento para validar as novas features do aplicativo.

### Topologia


## 2. Ambiente de Produção
Este template CloudFormation foi projetado para criar uma infraestrutura para o ambiente de produção. Ele inclui a criação de uma VPC, subnets públicas, um Internet Gateway, uma tabela de roteamento pública, instâncias EC2, grupos de segurança, um Application Load Balancer (ALB), um Target Group, um Auto Scaling Group (ASG), uma Launch Template e políticas de dimensionamento.

### Recursos
- Virtual Private Cloud (VPC):
    - Subnets Públicas: Duas subnets públicas para hospedar instâncias EC2 e outros recursos públicos;

    - Internet Gateway: Um gateway para permitir a comunicação entre a VPC e a Internet;

    - Tabela de Roteamento Pública: Uma tabela de roteamento para rotear o tráfego de saída para o Internet Gateway;

- Instâncias EC2: Instâncias EC2 que serão lançadas nas subnets públicas;

- Grupos de Segurança: Grupos de segurança com as menores autorizações possíveis para controlar o tráfego de rede para as instâncias EC2 e o Application Load Balancer;

- Application Load Balancer (ALB): Um balanceador de carga para distribuir o tráfego entre as instâncias EC2;

- Target Group: Um grupo de destino para o ALB para direcionar o tráfego para as instâncias EC2;

- Auto Scaling Group (ASG): Um grupo de dimensionamento automático para ajustar o número de instâncias EC2 com base na demanda de tráfego;

- Launch Template: Um modelo de lançamento para configurar as instâncias EC2 com a imagem, tipo de instância e outras configurações necessárias;

- Política de Dimensionamento: Uma política de dimensionamento para ajustar o número de instâncias EC2 com base em métricas de tráfego.

### Topologia


# Automatização de Implantação e Gerenciamento de Infraestrutura
Este repositório contém uma série de fluxos de trabalho (workflows) e ações (actions) para automatizar a implantação e o gerenciamento da infraestrutura de um projeto, bem como para a criação e atualização de ambientes de teste.

## Workflows Disponíveis
### 1. Destroy Infrastructure
Este workflow é acionado diariamente à meia-noite (UTC) e tem como objetivo destruir a infraestrutura de teste.

Quando é acionado: Cron job diário.
Ação realizada: Exclui a infraestrutura definida no arquivo infraestructure-test.yaml.
### 2. Create Environment Test
Este workflow é acionado quando há um push no branch development. Ele é responsável por criar e implantar um ambiente de teste.

Quando é acionado: Push para o branch development.
Ações realizadas:
Constrói e envia a imagem Docker marcotfm/zoologico:latest.
Implanta a infraestrutura definida no arquivo infraestructure-test.yaml.
Executa comandos SSH para atualizar as instâncias EC2 com a nova imagem Docker.
### 3. Deploy CloudFormation
Este workflow é acionado quando há um push no branch main e o arquivo infraestructure.yaml é modificado, ou de forma manual. Ele é responsável por implantar a infraestrutura de produção.

Quando é acionado: Push para o branch main que modifica o arquivo infraestructure.yaml.
Ações realizadas:
Constrói e envia a imagem Docker marcotfm/zoologico-ada:latest.
Implanta a infraestrutura definida no arquivo infraestructure.yaml.
### 4. Atualizar Ec2
Este workflow é acionado quando há um push no branch main que não modifica o arquivo infraestructure.yaml. Ele atualiza as instâncias EC2 com a imagem Docker mais recente.

Quando é acionado: Push para o branch main que não modifica o arquivo infraestructure.yaml.
Ações realizadas:
Constrói e envia a imagem Docker marcotfm/zoologico:latest.
Atualiza as instâncias EC2 com a nova imagem Docker.
Como Utilizar
Para utilizar estes workflows e ações em seu projeto, siga os passos abaixo:

### Configurar Credenciais e Segredos

Configure as credenciais da AWS e os segredos do Docker Hub em suas configurações de repositório como variáveis de ambiente secretas.
Modificar os Arquivos de Configuração

Personalize os arquivos infraestructure-test.yaml e infraestructure.yaml de acordo com os requisitos da sua infraestrutura.
Configurar os Eventos de Acionamento

Modifique os eventos de acionamento dos workflows conforme necessário, como branches específicos ou cron jobs.
Adaptar Comandos SSH

Se necessário, adapte os comandos SSH nos workflows para interagir com suas instâncias EC2.
Testar e Implantar

Após configurar e personalizar os arquivos e workflows, teste-os em um ambiente de desenvolvimento antes de implantá-los em produção.
>>>>>>> main
