# Docker Robot Framework + Appium

Este projeto utiliza o **Docker** para configurar e executar testes automatizados com **Robot Framework** e **Appium**, visando a automação de testes em aplicativos móveis. Através deste ambiente, você pode facilmente criar e rodar testes de forma isolada e sem necessidade de instalar o Appium localmente.

## Índice

- [Visão Geral](#visão-geral)
- [Tecnologias](#tecnologias)
- [Requisitos](#requisitos)
- [Configuração do Projeto](#configuração-do-projeto)
- [Execução dos Testes](#execução-dos-testes)

## Visão Geral

Este repositório configura um ambiente Dockerizado para execução de testes automatizados em dispositivos móveis utilizando Robot Framework e Appium. Esse setup facilita a criação e execução de testes, oferecendo um ambiente virtualizado e com menor dependência de configuração manual.

## Tecnologias

- **Docker**: Contêiner para isolamento e portabilidade do ambiente de testes.
- **Robot Framework**: Framework para automação de testes.
- **Appium**: Ferramenta de automação para testes de aplicativos móveis.
- **Python**: Linguagem utilizada para scripts de teste e configuração.

## Requisitos

Certifique-se de que os seguintes requisitos estejam atendidos antes de iniciar o projeto:

- [Docker](https://www.docker.com/) instalado e configurado.
- [Git](https://git-scm.com/) para clonar o repositório.
  
## Configuração do Projeto

Siga os passos abaixo para configurar o ambiente de teste:

1. Clone o repositório:
   ```bash
   git clone https://github.com/edugitQA/Docker_robot_appium.git
   cd Docker_robot_appium
2. Construa a imagem Docker:
   ```bash
   docker build -t robot-appium .

3. Configure o ambiente:

-   Verifique e atualize o arquivo de configuração Dockerfile e outros arquivos de configuração conforme necessário para seu ambiente de teste.
  
## Execução dos Testes

1. Para executar os testes, inicie o contêiner Docker com o seguinte comando:
   ```bash
   docker run -v $(pwd)/tests:/home/robot/tests robot-appium

obs: projeto pausado
