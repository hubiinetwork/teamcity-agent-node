#!/bin/bash
#
# 1. Merge PR with updated Dockerfile.
#    The merge action will by Github web-hooks push the new agent image to the docker registry.
# 2. Check timestamp in https://hub.docker.com/r/hubiinetwork/teamcity-agent-node
#    to see that the image is updated. That may take some time (e.g. 3-5 min).
# 2. Restart TC agents in development cluster.
# 3. Trigger some builds to see that the new agents work in development cluster.
# 4. When satisfied. Restart TC agent in production cluster.
# 5. Trigger some builds to see that the new agents work in production cluster.
#
# Be careful of which information that is put into the README.md file
# as that will be public.
#
# Restart TeamCity agents
# Below is a convenience script to run the image
# as a new TeamCity client on the hubinetwork TeamCity server.
# Follow up this docker-run with TeamCity configuration of the
# new agent and delete old agents if needed.
# The new agent will automatically be set up to run on AWS by
# the TeamCity server. You may want to check that old agents (AMIs) are removed
# from AWS if you delete them from TeamCity.
#
#  1. Ensure that you have aws-cli installed on your local computer
#  2. Ensure you are registered as an IAM user under the hubii AWS account.
#  3. Ensure you have docker installed on you local computer
#  4. Run this script. It may take a while before the agent is setup.
#     Look for the message:
#     "INFO -    jetbrains.buildServer.AGENT - Build agent started"
#     The script will not terminate since the docker-run is in the foregrount
#     with an virtuall tty attacked (-ti option)
#  5. Go to team city and authorize the new agent.
#     You may have to unauthorize one of the existing agents first if
#     agent licenses are limited.
#  6. Give the agent a name that reflects OS and node version (eg. linux-node-10x)
#  7. Assign the agent to an agent pool.
#  8. Disable all old agents in the pool.
#  9. Test the new agent by running a build;
#     preferably on a project that needes the new agent features.
# 10. Delete any old agents tha are obsolete.
#     Remember to take note of its AWS AMI first.
# 11. Ensure that the AMI has been removed from AWS.
# 12. Repreat this process for as many new agents that are needed

aws_credentials=$(node -p -e "($(aws sts get-session-token)).Credentials")

docker run -ti --privileged \
  -e SERVER_URL="https://ci.dev.hubii.net/" \
  -e DOCKER_IN_DOCKER=start \
  -e AWS_ACCESS_KEY_ID=$(node -p -e "($aws_credentials).AccessKeyId") \
  -e AWS_SECRET_ACCESS_KEY=$(node -p -e "($aws_credentials).SecretAccessKey") \
  -e AWS_DEFAULT_REGION=eu-west-1 \
  -v ~/.kube/config:/root/.kube/config \
  hubiinetwork/teamcity-agent-node:latest
