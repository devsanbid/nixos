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

    # ── Essentials ──────────────────────────────────────────
    tree
    unzip
    gzip
    htop
    inxi
    jq
    bc
    moreutils

    # ── Terminal tools ──────────────────────────────────────
    stow
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
