FROM ubuntu:16.04

COPY .gitconfig ~/.gitconfig
  
# Install dependencies.
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y apt-utils build-essential git vim checkinstall \
        libreadline-gplv2-dev libncursesw5-dev libssl-dev \
        libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev \
        wget apt-transport-https lsb-release ca-certificates curl \
        libzmq3-dev python

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
RUN cd /app/web-wallet/privatesky && npm install --unsafe-perm
