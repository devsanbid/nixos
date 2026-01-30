# System programs configuration
{ lib, pkgs, ... }: {

  programs = {
    # Shells
    zsh.enable = true;
    fish.enable = true;

    # Gaming
    steam.enable = true;

    # Utilities
    appimage.enable = true;
    dconf.enable = true;
    ydotool.enable = true;

    # Java
    java = {
      enable = true;
      package = pkgs.jdk;
    };

    # SSH askpass
    ssh.askPassword = lib.mkForce "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

    # Nix-ld for running unpatched binaries
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        glib
        gtk3
        libusb1
        udev
      ];
    };

    # nh - Nix Helper
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "$HOME/.dotfiles";
    };
  };
}
