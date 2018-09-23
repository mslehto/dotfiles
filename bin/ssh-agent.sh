#!/bin/sh

. ~/.sshrc > /dev/null
ssh-add -l 2>/dev/null
rc=$?

if [ $rc -lt 2 ]
then
  if [ $rc -lt 1 ]
  then
    echo "ssh-agent running already running, with identities"
  else
    echo "ssh-agent running already running"
  fi
else
  echo "ssh-agent not running, starting"
  SSH_AUTH_SOCK=~/.ssh/agent.$$
  ssh-agent -s -a $SSH_AUTH_SOCK > ~/.ssh/sshrc.new
  . ~/.ssh/sshrc.new
  rm -f ~/.ssh/sshrc.old
  mv ~/.sshrc ~/.ssh/sshrc.old
  mv ~/.ssh/sshrc.new ~/.sshrc
  . ~/.sshrc
  ssh-add -l 2>/dev/null
  rc=$?
  if [ $rc -lt 2 ]
  then
    rm -f ~/.ssh/agent.socket
    ln -s $SSH_AUTH_SOCK ~/.ssh/agent.socket
    echo "SSH_AUTH_SOCK=~/.ssh/agent.socket; export SSH_AUTH_SOCK;" >> ~/.sshrc
  else
    echo "ssh-agent startup failed rc=$rc"
  fi
fi
