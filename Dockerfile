# Usar uma imagem base com Python 3.12
FROM python:3.12-slim

# Instalar dependências do sistema necessárias
RUN apt-get update && apt-get install -y curl

# Instalar o Poetry
ENV POETRY_VERSION=1.6.1
RUN curl -sSL https://install.python-poetry.org | python3 -

# Adicionar o Poetry ao PATH
ENV PATH="/root/.local/bin:$PATH"

# Configurar variáveis de ambiente para Poetry
ENV POETRY_VIRTUALENVS_IN_PROJECT=true

# Definir o diretório de trabalho
WORKDIR /home/edu/Documentos/docker_rf

# Copiar os arquivos do projeto para o diretório de trabalho no container
COPY . /home/edu/Documentos/docker_rf

# Instalar dependências do projeto com o Poetry
RUN poetry install --no-root

# Comando padrão do container
CMD ["poetry", "shell"]
