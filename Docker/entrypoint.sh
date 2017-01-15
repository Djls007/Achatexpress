#!/usr/bin/env bash

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
BOLD="$(tput bold)"
NORMAL="$(tput  sgr0)"
else
RED=""
GREEN=""
YELLOW=""
BLUE=""
BOLD=""
NORMAL=""
fi

echo "Starting provisioning script ..."

echo ''
echo '---------------------------------------'
echo ''

echo "Install NodeJs packages"
/bin/bash -l -c "cd /home/docker && npm install"

echo ''
echo '---------------------------------------'
echo ''

echo "Start pm2 process"
/bin/bash -l -c "cd /home/docker && npm run pm2 start ecosystem.config.js"

echo ''
echo '---------------------------------------'
echo ''

printf "${YELLOW}"
echo "Success, Your are ready to develop ! :D"
printf "${NORMAL}"
echo ''
