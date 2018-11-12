# dh-slack-cleaner

## Build

docker build -t dh-slack-cleaner .

## Run

docker run --rm -it --env SLACK_TOKEN=XXX dh-slack-cleaner <days-to-retain> <slack-channel> <msg|bot> [commit]

Or store slack-token in file /etc/slack-token (to avoind having secrets on commandline) and run using:

docker run --rm -it --env SLACK_TOKEN=$(cat /etc/slack-token) dh-slack-cleaner <days-to-retain> <slack-channel> <msg|bot> [commit]
