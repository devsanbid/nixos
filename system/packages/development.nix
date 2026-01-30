# Development & Build Tools
{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # Editors & IDEs
    neovim
    helix
    vscode
    windsurf
    geany
    netbeans
    jetbrains.idea-community-bin

    # Version Control
    git
    git-lfs
    lazygit
    gitkraken
    gk-cli

    # Nix tools
    alejandra
    deadnix
    nil
    nixd
    niv
    nh
    home-manager
    statix

    # Languages & Runtimes
    python3
    python313Packages.pip
    pipx
    uv
    conda

    nodejs_22
    nodemon
    pnpm
    yarn
    bun
    typescript-language-server

    go
    rustup
    cargo

    lua
    lua5_1
    luarocks
    lua-language-server
    luajitPackages.lua-lsp

    R
    radian

    kotlin
    gradle
    jdk25
    mysql_jdbc

    flutter
    android-tools

    # Build tools
    gcc
    clang
    cmake
    meson
    ninja

    # DevOps
    ansible
    devbox
    docker
    podman
    distrobox

    # API & Testing
    postman
    atac
    requestly

    # Misc development
    diff-so-fancy
    entr
    lon
  ];
}
