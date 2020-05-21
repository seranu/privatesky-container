FROM ubuntu:16.04

COPY .gitconfig ~/.gitconfig

# Setup privatesky-server.
COPY privatesky-server /etc/init.d/  
RUN cd /etc/init.d && chmod +x privatesky-server \
      && update-rc.d privatesky-server defaults

# Install dependencies.
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y apt-utils build-essential git vim checkinstall \
        libreadline-gplv2-dev libncursesw5-dev libssl-dev \
        libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev \
        wget apt-transport-https lsb-release ca-certificates curl \
        libzmq3-dev python net-tools

RUN python --version

# Install nodejs.
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt install -y nodejs

# Build web-wallet.
RUN mkdir -p /app && cd /app \
      && git clone https://github.com/PrivateSky/web-wallet.git \
      && cd web-wallet \
      && npm install --unsafe-perm

# Build privatesky.
RUN cd /app/web-wallet/privatesky && npm install --unsafe-perm \
      && npm run build

EXPOSE 8080 5000 5001

# Run app.
ENTRYPOINT cd /app/web-wallet && service privatesky-server start && sleep 20 && npm run build-all \
              && /bin/bash
