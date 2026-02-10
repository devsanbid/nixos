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
        gtk4
        libusb1
        udev
        
        # Data science / Python packages
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
        
        # Chrome/Electron dependencies
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
        
        # X11 libraries
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
        
        # Wayland
        wayland
        
        # Additional
        fontconfig
        freetype
        libpulseaudio
        systemd
        
        # GBM (required by Chrome)
        mesa.drivers
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
