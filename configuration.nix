{ config, pkgs, nix-colors, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./system/app
      ./system/dm
      ./system/enviroment
      ./system/package
      ./system/security
      ./system/style
      ./system/wm
    ];
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      efiSupport = true;
      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      device = "nodev";
    };
  };

  system.autoUpgrade.enable = true;
  networking.hostName = "nixos";

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
    };
  };


  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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


  users.users.sanbid = {
    isNormalUser = true;
    description = "sanbid";
    extraGroups = [ "networkmanager" "libvirtd" "docker" "wheel" ];
    packages = with pkgs; [
    ];
  };


  # Install firefox.
  programs = {
    firefox.enable = true;
    fish.enable = true;
    appimage.enable = true;
  };

  #default shell
  users.defaultUserShell = pkgs.fish;
  environment.systemPackages = with pkgs; [
    vim
    neovim
    htop
    moreutils
    obs-studio
    obs-cli
    openssl
    pkg-config
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
    cargo
    rustc
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
    wayland-scanner.dev
    dig
    chromium
    glib

  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (
        nerdfonts.override {
          fonts = [ "FiraCode" "DroidSansMono" "Hack" "UbuntuMono" "NerdFontsSymbolsOnly" ];
        })
    ];
  };

  users.extraGroups.vboxusers.members = [ "sanbid" ];

  services = {
    ollama.enable = true;
  };

  # Allow unfree packages
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05"; # Did you read the comment?

}
