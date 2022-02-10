FROM jetbrains/teamcity-agent:2021.1.4

USER root
RUN chmod 1777 /tmp

# Update apt
RUN apt-get update

# Install curl and sudo
RUN apt-get install -y curl sudo

# Install node LTS
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
  apt-get install -y nodejs build-essential && \
  npm install -g npm@6.14.12

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install Ruby
RUN apt-get install -y ruby-full

# Install Python dependencies
RUN apt-get install -y python3-distutils

# Install AWS cli
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
  python3 get-pip.py && \
  pip install awscli --upgrade --user

# Install Azure cli
RUN apt-get install -y ca-certificates apt-transport-https lsb-release gnupg && \
  curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null && \
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/azure-cli.list && \
  apt-get update && \
  apt-get install -y azure-cli

ENV PATH=/root/.local/bin:$PATH

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/v1.19.15/bin/linux/amd64/kubectl" && \
  sudo install -o root -g root -m 0755 kubectl "/usr/bin/kubectl" && \
  rm -f kubectl

CMD "/run-services.sh"
