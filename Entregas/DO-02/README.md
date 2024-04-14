# Nome dos integrantes

# Nome do Projeto

# Proposta 


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
## 3. Deploy Test
Este workflow é acionado quando há um push no branch main e o arquivo infraestructure.yaml é modificado. Ele é responsável por implantar a infraestrutura de produção e atualizar o ambiente de teste.

Quando é acionado: Push para o branch main que modifica o arquivo infraestructure.yaml.
Ações realizadas:
Constrói e envia a imagem Docker marcotfm/zoologico-ada:latest.
Implanta a infraestrutura definida no arquivo infraestructure.yaml.
## 4. Atualizar Ec2
Este workflow é acionado quando há um push no branch main que não modifica o arquivo infraestructure.yaml. Ele atualiza as instâncias EC2 com a imagem Docker mais recente.

Quando é acionado: Push para o branch main que não modifica o arquivo infraestructure.yaml.
Ações realizadas:
Constrói e envia a imagem Docker marcotfm/zoologico:latest.
Atualiza as instâncias EC2 com a nova imagem Docker.
Como Utilizar
Para utilizar estes workflows e ações em seu projeto, siga os passos abaixo:

## Configurar Credenciais e Segredos

Configure as credenciais da AWS e os segredos do Docker Hub em suas configurações de repositório como variáveis de ambiente secretas.
Modificar os Arquivos de Configuração

Personalize os arquivos infraestructure-test.yaml e infraestructure.yaml de acordo com os requisitos da sua infraestrutura.
Configurar os Eventos de Acionamento

Modifique os eventos de acionamento dos workflows conforme necessário, como branches específicos ou cron jobs.
Adaptar Comandos SSH

Se necessário, adapte os comandos SSH nos workflows para interagir com suas instâncias EC2.
Testar e Implantar

Após configurar e personalizar os arquivos e workflows, teste-os em um ambiente de desenvolvimento antes de implantá-los em produção.