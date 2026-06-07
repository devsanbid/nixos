# CLI tools — modern Unix replacements
{ pkgs, ... }:

let
  nosql-booster-latest = pkgs.appimageTools.wrapType2 rec {
    pname = "nosql-booster";
    version = "10.1.7";
    src = pkgs.fetchurl {
      url = "https://s3.nosqlbooster.com/download/releasesv10/nosqlbooster4mongo-${version}.AppImage";
      sha256 = "1garj3q9h0daxv0x2mlj9v4j6q5pcmlh4frbdxrl4iy8cysdszf4";
    };
    appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/nosqlbooster4mongo.desktop $out/share/applications/nosqlbooster4mongo.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/nosqlbooster4mongo.png \
        $out/share/icons/hicolor/512x512/apps/nosqlbooster4mongo.png
      substituteInPlace $out/share/applications/nosqlbooster4mongo.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=nosql-booster'
    '';
  };
in
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
    nvd

    ntfs3g

    # ── Essentials ──────────────────────────────────────────
    tree
    unzip
    gzip
    htop
    inxi
    jq
    bc
    nosql-booster-latest
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
    gpu-screen-recorder
    gpu-screen-recorder-gtk

    hyperfine
    pv
    navi
    loganalyzer
    # yt-dlp
    mpc
    ashuffle

    wlr-randr
    nix-tree
  ];
}
