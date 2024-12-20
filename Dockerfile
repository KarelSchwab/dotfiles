FROM ubuntu:latest

ARG USER=karel
ARG GROUP=karel
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
  apt upgrade -y && \
  apt install -y sudo software-properties-common && \
  apt autoremove -y

RUN adduser --disabled-password --shell /bin/bash --home /home/${USER} ${USER}

RUN mkdir -p /etc/sudoers.d && \
  touch /etc/sudoers.d/${USER} && \
  echo "%${GROUP} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER}

# Install ansible
RUN sudo add-apt-repository --yes --update ppa:ansible/ansible && \
    sudo apt update && \
    sudo apt install -y ansible

# Set the working directory to the user's home directory
WORKDIR /home/$USER

# Switch to the new user by default
USER $USER

COPY . .

# CMD []
#
ENTRYPOINT ["/bin/bash"]
