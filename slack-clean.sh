#!/bin/bash

set -e

if [[ "$#" -lt 3 ]]; then
    echo -e "\nSYNTAX: $0 <days-to-retain> <slack-channel> <msg|bot> [--private] [--commit]\n"
    exit 1
fi

if [ -z ${SLACK_TOKEN} ]; then
    echo "No slack token found! Please set in env var SLACK_TOKEN. Script aborted"
    exit 1
fi

RETAIN_DAYS=$1
SLACK_CHANNEL="$2"


RETAIN_DATE=$(date --date="${RETAIN_DAYS} days ago" +%Y%m%d)

ARGS="--log "

if [[ "$@" == *"--private"* ]]; then
    # private channels require argument --group
    ARGS="${ARGS} --group ${SLACK_CHANNEL} "
else
    # public channels require argument --channel
    ARGS="${ARGS} --channel ${SLACK_CHANNEL} "
fi

if [[ "$@" == *"bot"* ]]; then
    ARGS="${ARGS} --message --bot "
elif [[ "$@" == *"msg"* ]]; then
    ARGS="${ARGS} --message --user *"
else
    echo "Type (bot/msg) must be specified!"
    exit 1
fi

if [[ "$@" == *"--commit"* ]]; then
    ARGS="${ARGS} --rate 1 --perform "
fi


echo "=== cleaning slack messages =============================="
echo "remove before ${RETAIN_DATE}"
echo "arguments: ${ARGS}"
echo "----------------------------------------------------------"

#slack-cleaner --help
echo "slack-cleaner --token ****** --before ${RETAIN_DATE} ${ARGS}"
slack-cleaner --token ${SLACK_TOKEN} --before ${RETAIN_DATE} ${ARGS}

echo "----------------------------------------------------------"

exit 0
