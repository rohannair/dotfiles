#!/bin/sh
# modern make
if which mmake >/dev/null 2>&2; then
  alias make='mmake'
fi

# exa is a better ls tool
if which exa >/dev/null 2>&1; then
  alias ls='exa'
  alias l='exa -la --git'
  alias la='exa -laa --git'
  alias ll='exa -l --git'
else
  if [ "$(uname -s)" = "Darwin" ]; then
    alias ls="ls -FG"
  else
    alias ls="ls -F --color"
  fi
  alias l="ls -lAh"
  alias la="ls -A"
  alias ll="ls -l"
fi

alias g="git"
alias grep="rg"
alias duf="du -sh * | sort -hr"
alias less="less -r"

alias find="fd"
alias c="bat"
alias cat="bat"
alias r="redis-cli"
alias redis="redis-cli"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias mkdir="mkdir -p"

alias webserver="python -m SimpleHTTPServer 9111"

# quick hack to make watch work with aliases
alias watch='watch '

# open, pbcopy and pbpaste on linux
if [ "$(uname -s)" != "Darwin" ]; then
  if [ -z "$(command -v pbcopy)" ]; then
    if [ -n "$(command -v xclip)" ]; then
      alias pbcopy="xclip -selection clipboard"
      alias pbpaste="xclip -selection clipboard -o"
    elif [ -n "$(command -v xsel)" ]; then
      alias pbcopy="xsel --clipboard --input"
      alias pbpaste="xsel --clipboard --output"
    fi
  fi
  if [ -e /usr/bin/xdg-open ]; then
    alias open="xdg-open"
  fi
fi
