{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.autoUpgrade.enable = true;
  networking.hostName = "nixos";

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
    };
  };
  # xdg.portal = { enable = true; extraPortals = [ pkgs.xdg-desktop-portal-hyprland ]; };


  environment.etc = {
    "resolv.conf".text = "nameserver 1.1.1.1\n";
  };

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security = {
    sudo.extraConfig = "sanbid ALL=(ALL:ALL) SETENV: ALL";
    rtkit.enable = true;
    polkit.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.sanbid = {
    isNormalUser = true;
    description = "sanbid";
    extraGroups = [ "networkmanager" "libvirtd" "docker" "wheel" ];
    packages = with pkgs; [
    ];
  };

  ## Enviroment varibale
  environment.sessionVariables = {
    FLAKE = "/home/sanbid/.dotfiles";
    OPENSSL_DIR = pkgs.openssl.dev;
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  # Install firefox.
  programs = {
    firefox.enable = true;
    fish.enable = true;
    appimage.enable = true;
    dconf.enable = true;
    # hyprland = {
    #   enable = true;
    # };
  };
  xdg.portal.enable = true;

  #default shell
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    htop
    webkitgtk_6_0
    webkitgtk_4_1
    moreutils
    obs-studio
    obs-cli
    openssl.dev
    pkg-config
    obsidian
    kotatogram-desktop
    brave
    kitty
    git
    dunst
    alacritty
    gtk4
    tmux
    python312Packages.pip
    vivid
    waybar
    wpaperd
    starship
    rustup
    ripgrep
    python312Packages.huggingface-hub
    fd
    dua
    stow
    ansible
    wofi
    brightnessctl
    bat
    bc
    dolphin
    kdePackages.dolphin-plugins
    dog
    fastfetch
    fzf
    gvfs
    gzip
    unzip
    jq
    lua
    luarocks
    mpv
    nodejs_22
    podman
    docker
    telegram-desktop
    tesseract
    sqlitebrowser
    xfce.thunar
    xfce.thunar-volman
    vlc
    acpi
    wpsoffice
    zoxide
    pamixer
    wlsunset
    fuzzel
    progress
    swappy
    atac
    tokei
    grim
    slurp
    python3Full
    libgcc
    gcc
    eza
    libreoffice
    ydotool
    libnotify
    pyprland
    libinput-gestures
    blueman
    swaybg
    hypridle
    wl-clipboard
    tealdeer
    ollama
    gnome-tweaks
    home-manager
    gparted
    kdePackages.partitionmanager
    python312Packages.pillow
    python312Packages.tkinter
    tk
    eog
    nh
    gnomeExtensions.nordvpn-quick-toggle
    figlet
    lolcat
    entr
    diff-so-fancy
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    dig
    chromium
  ];

  stylix = {
    enable = true;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 21;
    };
    fonts = {
      serif = {
        package = pkgs.roboto-serif;
        name = "Roboto Serif";
      };

      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto Serif";
      };

      monospace = {
        package = pkgs.roboto-mono;
        name = "roboto mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };


    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    opacity = {
      applications = 0.85;
      desktop = 0.85;
      popups = 1.0;
    };
    polarity = "dark";
    targets = {
      chromium.enable = true;
      fish.enable = true;
      gnome.enable = true;
      grub.enable = true;
      gtk.enable = true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (
        nerdfonts.override {
          fonts = [ "FiraCode" "DroidSansMono" "Hack" "UbuntuMono" ];
        })
    ];
  };

  users.extraGroups.vboxusers.members = [ "sanbid" ];
  virtualisation = {
    virtualbox.host.enable = true;
    virtualbox.host.enableExtensionPack = true;
    virtualbox.guest.enable = true;
    docker.enable = true;
    podman.enable = true;
    docker.rootless.enable = true;
  };

  services = {
    openssh.enable = true;
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    ollama.enable = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?

}
