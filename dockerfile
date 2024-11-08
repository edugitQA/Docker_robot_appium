# Usar uma imagem base com Python 3.12
FROM python:3.12-slim

# Instalar dependências do sistema necessárias
RUN apt-get update && apt-get install -y curl git

# Definir o diretório de trabalho
WORKDIR /home/edu/Documentos/docker_rf

# Copiar os arquivos do projeto para o diretório de trabalho no container
COPY . /home/edu/Documentos/docker_rf

# Copiar e instalar dependências
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Adicionar o AppiumLibrary ao PYTHONPATH diretamente
ENV PYTHONPATH="/home/edu/Documentos/docker_rf/.venv/lib/python3.12/site-packages"

# Expor a porta 8080
EXPOSE 8080

# Comando padrão do container
CMD ["robot", "seu_teste.robot"]
