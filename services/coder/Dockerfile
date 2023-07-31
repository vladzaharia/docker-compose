FROM codercom/code-server:latest

USER root

ENV CODER_ENV=true

# Copy install scripts
COPY --chmod=755 ./install/*.sh /tmp/scripts/install/

# Install scripts
RUN /tmp/scripts/install/docker.sh
RUN /tmp/scripts/install/nodejs.sh
RUN /tmp/scripts/install/starship.sh
RUN /tmp/scripts/install/utils.sh
RUN /tmp/scripts/install/vault.sh

RUN apt-get upgrade -y

USER vlad:vlad
