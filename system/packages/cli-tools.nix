# Command Line Utilities
{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # File operations
    bat
    eza
    fd
    fzf
    ripgrep
    tree
    unzip
    gzip

    # System info
    htop
    fastfetch
    inxi

    # Text processing
    jq
    bc
    moreutils

    # Shell enhancements
    starship
    zoxide
    vivid

    # Git & development
    stow
    tmux

    # Network
    wget
    dig

    # Fun
    figlet
    lolcat
    pastel
    progress
    tealdeer
    tree-sitter

    # Misc
    yad
    xdg-utils
  ];
}
