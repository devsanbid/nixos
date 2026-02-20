# System programs — shells, steam, nix-ld, nh
{ lib, pkgs, ... }:

{
  programs = {
    zsh.enable = true;
    fish.enable = true;
    steam.enable = true;
    appimage.enable = true;
    dconf.enable = true;
    ydotool.enable = true;

    java = {
      enable = true;
      package = pkgs.jdk;
    };

    ssh.askPassword = lib.mkForce "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

    # ── nix-ld — run unpatched binaries ─────────────────────
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        glib
        gtk3
        gtk4
        libusb1
        udev

        libffi
        openssl
        blas
        lapack
        xz
        libxml2
        libxslt
        readline
        ncurses
        sqlite

        nss
        nspr
        atk
        cups
        libdrm
        pango
        cairo
        mesa
        libGL
        libxkbcommon
        expat
        alsa-lib
        at-spi2-atk
        at-spi2-core
        dbus
        gdk-pixbuf

        xorg.libX11
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXrandr
        xorg.libxcb
        xorg.libXcursor
        xorg.libXi
        xorg.libXrender
        xorg.libXtst
        xorg.libXScrnSaver

        wayland

        fontconfig
        freetype
        libpulseaudio
        systemd

        mesa.drivers
      ];
    };

    # ── nh — Nix helper ─────────────────────────────────────
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "$HOME/.dotfiles/nixos-config";
    };
  };
}
