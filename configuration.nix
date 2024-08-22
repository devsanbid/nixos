{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      efiSupport = true;
      useOSProber = true;

      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      device = "nodev";
    };
  };
  system.autoUpgrade.enable = true;
  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
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
    rtkit.enable = true;
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
    extraGroups = [ "networkmanager" "libvirtd" "docker" ];
    packages = with pkgs; [
    ];
  };

  # Install firefox.
  programs = {
    firefox.enable = true;
    virt-manager.enable = true;
    fish.enable = true;
    appimage.enable = true;
    dconf.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    xwayland.enable = true;
  };

  #default shell
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    htop
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
    polkit
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
    polkit_gnome
    python312Packages.pillow
    python312Packages.tkinter
    tk
    eog
    ollama-rocm
  ];

  security = {
    polkit = {
      enable = true;
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
  virtualisation = {
    libvirtd.enable = true;
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
