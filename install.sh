#!/bin/zsh

if [ ! command -v brew &>/dev/null ]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ ! command -v nix &>/dev/null ]; then
  echo "Installing Nix"
  mkdir /nix
  chown $USER /nix
  sh <(curl -L https://nixos.org/nix/install) --no-daemon
fi

brew bundle --file="$DOTFILES/Brewfile"

stow -Sv zsh
stow -Sv git
stow -Sv vim
stow -Sv postgres

# better diffs
if which diff-so-fancy >/dev/null 2>&1; then
  git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi
