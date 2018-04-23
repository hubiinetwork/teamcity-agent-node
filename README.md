# hubiinetwork/teamcity-agent-node

## Description
This is a Docker image for TeamCity build agents which comes with Node.js LTS (8.x), AWS cli and kubectl for Kubernetes installed. It is based  on the [official JetBrains TeamCity build agent image](https://hub.docker.com/r/jetbrains/teamcity-agent/).


It is used the same way as the official image from JetBrains, but also supports some configuration for AWS cli and Kubernetes. 

When the TeamCity agent and server runs in the same Kubernetes cluster it is able to pick up the kubernetes config automatically, and you do not need to mount the .kube/config.

```
docker run -ti --privileged \
  -e SERVER_URL=<TeamCity server url> \
  -e DOCKER_IN_DOCKER=start \
  -e AWS_ACCESS_KEY_ID=<AWS access key> \
  -e AWS_SECRET_ACCESS_KEY=<AWS secret access key> \
  -e AWS_DEFAULT_REGION=<AWS default region> \
  -v ~/.kube/config:/root/.kube/config \
  hubiinetwork/teamcity-agent-node:latest
```


Read the [JetBrains TeamCity build agent documentation for more information](https://hub.docker.com/r/jetbrains/teamcity-agent/).
