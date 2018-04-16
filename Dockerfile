FROM jetbrains/teamcity-agent

RUN apt-get update && \
  apt-get install curl sudo -y && \
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
  sudo apt-get install -y nodejs build-essential && \
  npm install npm@latest -g

CMD "/run-services.sh"