FROM ubuntu:16.04
COPY ~/.gitconfig ~/.gitconfig
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y build-essential git vim checkinstall \
        libreadline-gplv2-dev libncursesw5-dev libssl-dev \
        libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev \
        wget apt-transport-https lsb-release ca-certificates curl 

# Install python2.7
RUN cd /usr/src && wget https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz \
      && tar xzf Python-2.7.16.tgz \
      && cd Python-2.7.16 \
      && ./configure --enable-optimizations \
      && make install

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt install -y nodejs

# web-wallet
RUN mkdir -p /app && cd /app \
      && git clone https://github.com/PrivateSky/web-wallet.git \
      && cd web-wallet \
      && npm install --unsafe-perm \

# privatesky
RUN cd /app/web-wallet/privatesky && npm install --unsafe-perm
