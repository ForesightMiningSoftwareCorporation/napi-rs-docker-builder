#!/bin/sh

cp -R /ssh/.gitconfig ~/.gitconfig
cp -R /ssh/.ssh ~/.ssh

chown root:root ~/.gitconfig
chown -R root:root ~/.ssh

sed 's|/home/runner|/root|g' -i.bak ~/.ssh/config

RUN echo -e '\n[url "ssh://git@github.com/ForesightMiningSoftwareCorporation"]\n  insteadOf = https://github.com/ForesightMiningSoftwareCorporation' >> /root/.gitconfig

mkdir -p -m 0600 ~/.ssh && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# This will exec the CMD from your Dockerfile, i.e. "npm start"
exec "$@"