# hubiinetwork/teamcity-agent-node

## Description
This is a Docker image based on the [official JetBrains TeamCity build agent image](https://hub.docker.com/r/jetbrains/teamcity-agent/). 

The only difference is that it comes with Node.js LTS (8.x) and the latest npm version installed.

It is used the same way as the official image from JetBrains:

```
docker run -it -e SERVER_URL="<url to TeamCity server>"  \ 
    -v <path to agent config folder>:/data/teamcity_agent/conf  \      
    hubiinetwork/teamcity-agent-node
```

Read the [JetBrains TeamCity build agent documentation for more information](https://hub.docker.com/r/jetbrains/teamcity-agent/).