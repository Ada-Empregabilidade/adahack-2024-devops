# Nome dos integrantes
- Danilo Argolo [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/danargolo)
- Diego Lopes [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/Diegox0301)
- Felipe Clemente [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/felipemike)
- Gracielly Ribeiro [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/GraciellySRibeiro)
- Gustavo Pinheiro [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/Gustavopnhro)
- Joniel Oliveira [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/JonielOliveira)
- Madson Rocha [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/madsonsd)
- Marco Tulio [![GitHub Badge](https://img.shields.io/badge/GitHub-Profile-blue?logo=github)](https://github.com/MarcoTulioFM)

# Nome do Projeto
<p style='font-size:30px;text-align:center; font-weight:bold'> AnimalConnect </p>

<div style="display:flex; align-items:center; justify-content:center">
    <img src="./assets/logo.png" style="height:200px; display:flex; align-items:center; justify-content:center">
</div>

# Proposta

# Topologia do Projeto
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

- Lambda Serveless: Função Lambda criada para o controle de máquina no ambiente de testes, sua principal função é desligar todas as instâncias meia-noite (UTC) todos os dias.

#### Descrição da Função Lambda 
A função Lambda definida neste template é responsável por terminar instâncias EC2 do ambiente de teste que sao marcadas com a tag "stack" igual a "dev". Essa função é acionada diariamente à meia-noite (UTC) por meio de uma regra de agendamento (Schedule Rule) configurada para esse fim.

#### Funcionamento
Quando a função Lambda é acionada pelo evento programado, ela utiliza a biblioteca boto3 para interagir com a AWS. Primeiramente, a função faz uma chamada para o serviço EC2 para obter uma lista de todas as instâncias em execução que possuem a tag "stack" com valor "dev" e estão marcadas como "running" (em execução).

Em seguida, itera sobre cada instância retornada e obtém o ID da instância. Com esses IDs, a função utiliza o serviço EC2 novamente para terminar (desligar) essas instâncias.

Após a conclusão da terminação das instâncias, a função retorna um objeto JSON com um código de status HTTP 200 indicando que as instâncias foram terminadas com sucesso.

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

# Automatização de Implantação e Gerenciamento de Infraestrutura
Este repositório contém uma série de fluxos de trabalho (workflows) e ações (actions) para automatizar a implantação e o gerenciamento da infraestrutura de um projeto, bem como para a criação e atualização de ambientes de teste.

## Workflows Disponíveis
### 1. Create Environment Test
Este workflow é acionado quando há um push no branch development. Ele é responsável por criar e implantar um ambiente de teste.

Quando é acionado:
- Push para o branch development.

<b>Ações realizadas:</b>
- Constrói e envia a imagem Docker marcotfm/zoologico:latest;
- Implanta a infraestrutura definida no arquivo infraestructure-test.yaml;
- Executa comandos SSH para atualizar as instâncias EC2 com a nova imagem Docker.

### 2. Deploy CloudFormation
Este workflow é acionado quando há um push no branch main e o arquivo infraestructure.yaml é modificado, ou de forma manual. Ele é responsável por implantar a infraestrutura de produção.

Quando é acionado:
- Push para o branch main que modifica o arquivo infraestructure.yaml.

<b>Ações realizadas:</b>
- Constrói e envia a imagem Docker marcotfm/zoologico-ada:latest.
- Implanta a infraestrutura definida no arquivo infraestructure.yaml.

### 3. Update EC2
Este workflow é acionado quando há um push na branch "main" e realiza uma modificação nos arquivos da pasta "backend". Ele atualiza as instâncias EC2 com a imagem Docker mais recente.

Quando é acionado:
- Push para o branch main que modifica arquivos na pasta "backend".

<b> Ações realizadas: </b>
- Constrói e envia a imagem Docker marcotfm/zoologico:latest.
- Atualiza as instâncias com rolling update.

#### Como Utilizar

Para utilizar estes workflows e ações em seu projeto, siga os passos abaixo:

##### Configurar Credenciais e Segredos
- Configure as credenciais da AWS e os segredos do Docker Hub em suas configurações de repositório como variáveis de ambiente secretas.
- Modificar os Arquivos de Configuração

- Personalize os arquivos infraestructure-test.yaml e infraestructure.yaml de acordo com os requisitos da sua infraestrutura.

- Configure os eventos de acionamento


