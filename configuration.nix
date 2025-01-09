{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./system
    # ./patchpoetry.nix
  ];

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

  networking.hostName = "nixos";

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
    GDK_SCALE = "2.5";

    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
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
    extraGroups = ["networkmanager" "libvirtd" "docker" "wheel" "ydotool"];
    packages = with pkgs; [
    ];
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  # Install firefox.
  programs = {
    firefox.enable = true;
    fish.enable = true;
    appimage.enable = true;
    java.enable = true;
    ydotool = {
      enable = true;
    };
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];

  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [
      xfce.xfconf
    ];
  };

  services.gvfs.enable = true;

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    colloid-icon-theme = pkgs.colloid-icon-theme.override {colorVariants = ["teal"];};
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = ["teal"]; # You can specify multiple accents here to output multiple themes
      size = "standard";
      variant = "macchiato";
    };
    discord = pkgs.discord.override {
      withOpenASAR = true;
      withTTS = true;
    };
  };
  hardware.nvidia-container-toolkit.enable = true;
  nix.settings.trusted-users = ["root" "sanbid"];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  systemd.services.ollama.serviceConfig = {
    DeviceAllow = lib.mkForce [
      "char-nvidia"
      "char-nvidia-modeset"
      "char-nvidiactl"
      "char-nvidia-nvswitch"
      "char-nvidia-nvlink"
      "char-nvidia-caps"
      "char-nvidia-caps-imex-channels"
      "char-nvidia-uvm"
      "char-nvidia-frontend"
    ];
    DevicePolicy = lib.mkForce "auto";
  };

  #default shell
  users.defaultUserShell = pkgs.fish;
  environment.systemPackages = with pkgs; [
    wget
    isoimagewriter
    cudatoolkit
    nvtopPackages.nvidia
    # cudaPackages.cudatoolkit
    # cudatoolkit
    pipx
    conda
    vim
    rust-analyzer
        swww
    ghostty
    onnxruntime
    lmstudio
    cudaPackages.libcublas
    wlogout
    pulseaudio
    virt-manager

    devbox
    mysql_jdbc
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    wlrctl
    nvitop

    wtype
    xdg-utils
    qbittorrent

    wl-clip-persist
    swappy
    lua5_1
    imagemagick
    ffmpeg_6-full
    deadnix
    at-spi2-atk
    qt6.qtwayland
    sway
    psi-notify
    poweralertd
    playerctl
    psmisc
    numix-icon-theme-circle
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
    catppuccin-cursors.macchiatoTeal
    neovim
    hyprpicker
    hyprcursor
    hyprlock
    cool-retro-term
    imv
    onefetch
    sumneko-lua-language-server
    hyprls
    emmet-language-server
    tree

    nil
    hyprpaper
    htop
    jdk
    heroic
    lutris
    poetry
    python3
    micromamba
    netbeans
    python312Packages.pandas
    python312Packages.seaborn
    python312Packages.matplotlib
    python312Packages.numpy
    vscode
    luajitPackages.lua-lsp
    grimblast
    libinput-gestures
    rust-analyzer
    wgnord
    comic-mono
    wmctrl
    moreutils
    openssl
    pkg-config
    brave
    greetd.gtkgreet
    kitty
    git
    dunst
    alacritty
    gtk4
    bun
    tmux
    vivid
    waybar
    wpaperd
    starship
    inxi

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
    python3
    libgcc
    gcc
    eza
    uv
    micromamba
    libreoffice
    libnotify
    libinput-gestures
    blueman
    swaybg
    wl-clipboard
    tealdeer
    gnome-tweaks
    home-manager
    gparted
    kdePackages.partitionmanager
    eww
    tk
    eog
    nh
    gnomeExtensions.nordvpn-quick-toggle
    figlet
    lolcat
    entr
    diff-so-fancy
    libsForQt5.qtstyleplugin-kvantum
    ollama-cuda
    nwg-look
    libsForQt5.qt5ct
    wayland-scanner.dev
    dig
    chromium
    lenovo-legion
    glib
    mycli
    alejandra
    nixd
  ];

  services.xserver.videoDrivers = ["nvidia"];
  services.desktopManager.plasma6.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      ];
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.hack
      nerd-fonts.noto
      nerd-fonts.comic-shanns-mono
      nerd-fonts.monofur
      nerd-fonts.mononoki
      nerd-fonts.iosevka
      nerd-fonts.symbols-only
      nerd-fonts.ubuntu-mono
      nerd-fonts.sauce-code-pro
      gyre-fonts
    ];
  };

  nixpkgs.config.cudaSupport = true;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  users.extraGroups.vboxusers.members = ["sanbid"];

  services = {
    hypridle.enable = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.05"; # Did you read the comment?
}
