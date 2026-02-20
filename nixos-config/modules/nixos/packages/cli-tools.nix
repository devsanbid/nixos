# CLI tools — modern Unix replacements
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ── Modern replacements ─────────────────────────────────
    bat           # cat → bat
    eza           # ls → eza
    fd            # find → fd
    fzf           # fuzzy finder
    ripgrep       # grep → rg
    zoxide        # cd → z
    vivid         # LS_COLORS generator
    starship      # prompt

    # ── Essentials ──────────────────────────────────────────
    tree
    unzip
    gzip
    htop
    fastfetch
    inxi
    jq
    bc
    moreutils

    # ── Terminal tools ──────────────────────────────────────
    stow
    tmux
    wget
    dig

    # ── Fun/misc ────────────────────────────────────────────
    figlet
    lolcat
    pastel
    progress
    tealdeer
    tree-sitter

    yad
    xdg-utils
  ];
}
