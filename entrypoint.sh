#!/bin/sh

ls -alh /ssh
cp -R /ssh/.ssh /root/.ssh
cp /ssh/.gitconfig /root/.gitconfig

chown root:root ~/.gitconfig
chown -R root:root ~/.ssh

sed 's|/home/runner|/root|g' -i.bak ~/.ssh/config

echo -e '\n[url "ssh://git@github.com"]\n  insteadOf = https://github.com' >> /root/.gitconfig

mkdir -p -m 0600 ~/.ssh && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# This will exec the CMD from your Dockerfile, i.e. "npm start"
exec "$@"