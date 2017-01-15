FROM ubuntu:14.04

ARG DOCKER_USER
ARG NODE_PORT

# Install Base for dev
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        git \
        tig \
        sudo \
        htop \
        ncdu \
        python-software-properties \
        software-properties-common \
        python

# Install NodeJs
RUN apt-get update
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs

# Add user DOCKER_USER defined in .env & give sudo privilege
RUN adduser --disabled-password --gecos '' ${DOCKER_USER}
RUN adduser ${DOCKER_USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Override default bash config
ADD .bashrc /home/${DOCKER_USER}/.bashrc

# Add Provisionning Scripts
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Install PM2
RUN npm install pm2 -g

EXPOSE ${NODE_PORT}
CMD ["pm2-docker", "ecosystem.config.js"]
