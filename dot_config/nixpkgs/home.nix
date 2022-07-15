{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rohan";
  home.homeDirectory = "/Users/rohan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Packages
  home.packages = with pkgs; [
    # Shell
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search

    bat
    bottom

    comma
    delta
    direnv
    exa
    fd
    flyctl
    fzf
    git
    gnupg
    htop
    jq
    neovim
    pinentry_mac
    gnupg
    ripgrep
    starship
    tldr
    tmux
    tree
    wget
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
