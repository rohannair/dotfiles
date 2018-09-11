#!/bin/sh
if which hub >/dev/null 2>&1; then
  alias git='hub'
fi

alias g="git"
alias gl = 'git pull --prune'
alias gp = 'g push'
