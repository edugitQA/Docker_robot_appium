# Usar uma imagem base com Python 3.12
FROM python:3.12-slim

# Definir o modo de frontend do Debian para não interativo
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependências do sistema necessárias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    unzip \
    openjdk-17-jdk \
    libgl1-mesa-glx \
    qemu-kvm \
    libvirt-daemon-system \
    libvirt-clients \
    bridge-utils \
    sudo \
    dash

# Definir o JDK como padrão
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Instalar o Appium globalmente
RUN npm install -g appium

# Instalar o driver uiautomator2 do Appium (necessário para testes Android)
RUN appium driver install uiautomator2

# Configurar variáveis de ambiente para o Android SDK
ENV ANDROID_HOME=/usr/local/android-sdk
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH

# Definir o diretório de trabalho
WORKDIR /home/edu/Documentos/docker_rf

# Copiar os arquivos do projeto para o diretório de trabalho no container
COPY . /home/edu/Documentos/docker_rf

# Copiar e instalar dependências do Python
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Adicionar o AppiumLibrary ao PYTHONPATH diretamente
ENV PYTHONPATH="/home/edu/Documentos/docker_rf/.venv/lib/python3.12/site-packages"

# Expor a porta padrão do Appium (4723)
EXPOSE 4723

# Comando para iniciar o Appium
CMD ["appium", "--base-path", "/wd/hub", "--address", "0.0.0.0"]