FROM jetbrains/teamcity-agent

# Install node LTS
RUN apt-get update && \
  apt-get install curl sudo -y && \
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
  apt-get install -y nodejs build-essential && \
  npm install npm@latest -g

# Install Ruby
RUN apt-get install ruby-full -y

# Install aws cli
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  pip install awscli --upgrade --user

ENV PATH=/root/.local/bin:$PATH

# Install kubectl
RUN apt-get install -y apt-transport-https && \
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list && \
  apt-get update && \
  apt-get install -y kubectl

CMD "/run-services.sh"
