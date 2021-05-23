#!/bin/bash
set -eu
pwd

SSH_CONFIG_PATH="$HOME/.ssh"
test -d "$SSH_CONFIG_PATH" || mkdir -p "$SSH_CONFIG_PATH"

echo -e "$DEPLOY_KEY" > $SSH_CONFIG_PATH/key
chmod 600 $SSH_CONFIG_PATH/key

echo -e "$SSL_CLIENT_KEY" > $SSH_CONFIG_PATH/ssl.key
echo -e "$SSL_CLIENT_PEM" > $SSH_CONFIG_PATH/ssl.pem

echo "Host *" > "$SSH_CONFIG_PATH/config"
echo "  User $USERNAME" >> "$SSH_CONFIG_PATH/config"
echo "  StrictHostKeyChecking no" >> "$SSH_CONFIG_PATH/config"
echo "  IdentityFile $SSH_CONFIG_PATH/key" >> "$SSH_CONFIG_PATH/config"
echo "  ProxyCommand $ARGS" >> "$SSH_CONFIG_PATH/config"
echo "  ForwardAgent yes" >> "$SSH_CONFIG_PATH/config"

cat "$SSH_CONFIG_PATH/config"

scp -F $SSH_CONFIG_PATH/config -r $GITHUB_WORKSPACE/$FOLDER $SERVER_IP:$SERVER_DESTINATION
