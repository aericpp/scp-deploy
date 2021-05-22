#!/bin/bash
set -eu

SSH_CONFIG_PATH="$HOME/.ssh"
test -d "$SSH_CONFIG_PATH" || mkdir -p "$SSH_CONFIG_PATH"

echo -e "$DEPLOY_KEY" > $SSH_CONFIG_PATH/key
chmod 600 $SSH_CONFIG_PATH/key

echo -e "$SSL_CLIENT_KEY" > $SSH_CONFIG_PATH/ssl.key
echo -e "$SSL_CLIENT_PEM" > $SSH_CONFIG_PATH/ssl.pem

scp $ARGS -i "$SSH_CONFIG_PATH/key" -o StrictHostKeyChecking=no -o User="$USERNAME" -r "$GITHUB_WORKSPACE/$FOLDER" $SERVER_IP:$SERVER_DESTINATION
