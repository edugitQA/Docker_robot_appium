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
    virt-manager \
    sudo \
    dash

# Definir o JDK como padrão
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Instalar o Appium globalmente
RUN npm install -g appium

# Instalar o driver uiautomator2 do Appium
RUN appium driver install uiautomator2

# Instalar o Android SDK
RUN curl -fL -o sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip \
    && mkdir -p /usr/local/android-sdk/cmdline-tools \
    && unzip sdk.zip -d /usr/local/android-sdk/cmdline-tools \
    && mv /usr/local/android-sdk/cmdline-tools/cmdline-tools /usr/local/android-sdk/cmdline-tools/latest \
    && rm sdk.zip

# Configurar as variáveis de ambiente do Android SDK
ENV ANDROID_HOME=/usr/local/android-sdk
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH

# Aceitar as licenças do SDK
RUN yes | sdkmanager --licenses

# Instalar as ferramentas SDK necessárias, incluindo o emulador
RUN sdkmanager "platform-tools" "platforms;android-29" "emulator" "system-images;android-29;default;x86_64"

# Criar um dispositivo virtual Android (AVD) com partição de tamanho menor
RUN echo "no" | avdmanager create avd -n test_avd -k "system-images;android-29;default;x86_64" --device "pixel" --force --sdcard 2048M

# Definir o diretório de trabalho
WORKDIR /home/edu/Documentos/docker_rf

# Copiar os arquivos do projeto para o diretório de trabalho no container
COPY . /home/edu/Documentos/docker_rf

# Copiar e instalar dependências do Python
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Adicionar o AppiumLibrary ao PYTHONPATH diretamente
ENV PYTHONPATH="/home/edu/Documentos/docker_rf/.venv/lib/python3.12/site-packages"

# Expor as portas para o Appium (4723) e a aplicação (8080)
EXPOSE 4723 8080

# Comando para iniciar o Appium, o emulador Android e executar o teste
CMD ["sh", "-c", "sudo modprobe kvm && appium --base-path /wd/hub --address 0.0.0.0 & emulator -avd test_avd -no-window -no-audio -partition-size 2048 & robot seu_teste.robot"]
