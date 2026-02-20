# Development tools — editors, languages, build tools
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ── Editors ─────────────────────────────────────────────
    neovim
    helix
    vscode
    windsurf
    geany
    netbeans

    # ── Git ─────────────────────────────────────────────────
    git
    git-lfs
    lazygit
    gitkraken
    gk-cli

    # ── Nix tooling ─────────────────────────────────────────
    alejandra
    deadnix
    nil
    nixd
    niv
    nh
    home-manager
    statix

    # ── Python ──────────────────────────────────────────────
    python3
    python313Packages.pip
    pipx
    uv
    conda
    gnumake

    # ── JavaScript/TypeScript ───────────────────────────────
    nodejs_22
    nodemon
    pnpm
    yarn
    bun
    typescript-language-server

    # ── Systems languages ───────────────────────────────────
    go
    rustup
    cargo

    # ── Lua ─────────────────────────────────────────────────
    lua
    lua5_1
    luarocks
    lua-language-server
    luajitPackages.lua-lsp

    # ── Data Science ────────────────────────────────────────
    R
    radian

    # ── JVM ─────────────────────────────────────────────────
    kotlin
    gradle
    jdk25
    mysql_jdbc

    # ── C/C++ / Build ───────────────────────────────────────
    gcc
    clang
    cmake
    meson
    ninja

    # ── DevOps ──────────────────────────────────────────────
    ansible
    devbox
    docker
    podman
    distrobox

    # ── API tools ───────────────────────────────────────────
    postman
    atac
    requestly

    # ── Misc dev ────────────────────────────────────────────
    diff-so-fancy
    entr
    lon
  ];
}
