#!/bin/zsh
# shortcut to this dotfiles path is $DOTFILES
export DOTFILES="$HOME/.dotfiles"

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
# shellcheck disable=SC1090
[ -f ~/.localrc ] && . ~/.localrc

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

eval "$(direnv hook zsh)"
source <(antibody init)

antibody bundle < ~/.zsh_plugins.txt

## Aliases
alias crontab='echo fuck off'
autoload -U promptinit; promptinit
prompt pure

alias mv="mv -i"
alias cp="cp -i"

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

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias mkdir="mkdir -p"

# quick hack to make watch work with aliases
alias watch='watch '

alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

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

if which hub >/dev/null 2>&1; then
  alias git='hub'
fi

alias g="git"

if which brew >/dev/null 2>&1; then
  brew() {
    case "$1" in
    cleanup)
      (cd "$(brew --repo)" && git prune && git gc)
      command brew cleanup
      command brew prune
      rm -rf "$(brew --cache)"
      ;;
    bump)
      command brew update
      command brew upgrade
      brew cleanup
      ;;
    *)
      command brew "$@"
      ;;
    esac
  }
fi


## Functions
# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_";
}

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
  function diff() {
    git diff --no-index --color-words "$@";
  }
fi;

# Normalize `open` across Linux, macOS, and Windows.
# This is needed to make the `o` function (see below) cross-platform.
if [ ! $(uname -s) = 'Darwin' ]; then
  if grep -q Microsoft /proc/version; then
    # Ubuntu on Windows using the Linux subsystem
    alias open='explorer.exe';
  else
    alias open='xdg-open';
  fi
fi

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
  if [ $# -eq 0 ]; then
    open .;
  else
    open "$@";
  fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function fuck() {
  git oops;
  git please;
}

function reload() {
  exec "$SHELL" -l
}