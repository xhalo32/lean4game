#!/usr/bin/env sh

# Set HOME explicitly to support running the container as root
export HOME=/home/node

. ~/.profile

cd games/xhalo32/constructivelogiccoursegame

# lake exe cache clean
# lake exe cache get
lake build -R

file .lake/packages/GameServer/server/.lake/build/bin/gameserver

cd /usr/src/app

elan default stable

lake env printenv ELAN_HOME

npm run production
