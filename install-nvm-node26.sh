#!/bin/bash

# Install NVM and Node.js 26
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install 26
nvm use 26
npm install
npm run format
./node_modules/.bin/prettier --write .
npm run format:check
npm run ci:local
npm run format  # One thing to note: don't manually reformat package.json to fix this. Let Prettier do it
git diff --stat
sudo rm -rf node_modules


# This will generate a new package-lock.json file