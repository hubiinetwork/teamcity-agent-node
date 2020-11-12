
# hubiinetwork/teamcity-agent-node

## How to update TeamCity agents
TeamCity agents run on Kubernetes clusters.
There are two clusters, one for development and one for production.
The deployment files (`agent.yaml`) can be found in the project `omphalos-deployment`.

Updated TeamCity agent images are automatically uploaded to
https://hub.docker.com/r/hubiinetwork/teamcity-agent-node
when `teamcity-agent-node` master branch is updated.
That may take some time (e.g. 3-5 min).

1. Merge PR with updated Dockerfile into the master branch.
2. Wait a bit and then check timestamp in https://hub.docker.com/r/hubiinetwork/teamcity-agent-node
to see that the image is updated.
2. Restart TC agents in development cluster.
3. Trigger some builds to see that the new agents work in development cluster.
4. When satisfied; Restart TC agent in production cluster.
5. Trigger some builds to see that the new agents work in production cluster.

## Server configuration
The server contains a set of manual updates which are currently not managed as provisions.
This means that new TeamCity server must be configured manually with resources as secrets, access rights and projects.
Basically TeamCity must be able to
* Clone repos from GitHub,
* Exchange notifications with GitHub,
* Push new images to the AWS registry,
* Publish npm packages to the npm registry.

Most of this stuff is clear from the context.
More obscure are the custom meta-runners which is store on the server.
We have stored a snapshot of the meta-runners in this repo as a reference.

