FROM jetbrains/teamcity-agent:2020.2.2

USER root

# Update apt
RUN apt-get update

# Install curl and sudo
RUN apt-get install -y curl sudo

# Install node LTS
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
  apt-get install -y nodejs build-essential && \
  npm install -g npm@latest

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
RUN apt-get install -y apt-transport-https && \
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list && \
  apt-get update && \
  apt-get install -y kubectl

CMD "/run-services.sh"
