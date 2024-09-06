{ config, pkgs, nix-colors, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
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

  services.xserver.enable = true;
  services.xserver.desktopManager.budgie.enable = true;


  environment.etc = {
    "resolv.conf".text = "nameserver 1.1.1.1\n";
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
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    GTK_THEME = "Tokyonight-Dark-B";
  };

  #Stylix
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = nix-colors.colorSchemes.oxocarbon-dark;
    fonts = rec {
      monospace = {
        package = pkgs.fantasque-sans-mono;
        name = "Fantasque Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 14;
        desktop = 14;
        popups = 14;
        terminal = 16;
      };
    };
    opacity = {
      terminal = 0.90;
      popups = 0.90;
      desktop = 0.90;
    };
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 32;
    };
  };
  fonts = {
    fontconfig.defaultFonts = rec {
      sansSerif = [ "Kollektif" "Mamelon" ];
      serif = sansSerif;
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # Install firefox.
  programs = {
    firefox.enable = true;
    fish.enable = true;
    appimage.enable = true;
    dconf.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
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
  virtualisation = {
    # virtualbox.host.enable = true;
    # virtualbox.host.enableExtensionPack = true;
    # virtualbox.guest.enable = true;
    docker.enable = true;
    podman.enable = true;
    docker.rootless.enable = true;
  };

  services = {
    openssh.enable = true;
    displayManager = {
      sddm = {
        wayland.enable = true;
        enable = true;
      };

    };
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    ollama.enable = true;
  };

  # Allow unfree packages
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05"; # Did you read the comment?

}
