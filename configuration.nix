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
  ];

  #############################################################################
  #                              BOOT CONFIGURATION                           #
  #############################################################################
  boot = {
    # EFI and GRUB bootloader configuration
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        useOSProber = true; # Auto-detect other operating systems
        fontSize = 32;
        default = "saved";
        device = "nodev"; # Install GRUB to the EFI directory, not to a device
      };
    };

    # Kernel parameters for NVIDIA
    kernelParams = ["nvidia-drm.modeset=1"];
  };

  #############################################################################
  #                           NETWORKING CONFIGURATION                        #
  #############################################################################

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [443]; # Allow HTTPS traffic
  };

  #############################################################################
  #                            SYSTEM ENVIRONMENT                             #
  #############################################################################
  # Set up global environment variables
  environment.sessionVariables = rec {
    # XDG base directories
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";

    # NVIDIA/CUDA configuration
    CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";

    # Display scaling
    GDK_SCALE = "1";

    # Add local bin to PATH
    PATH = ["${XDG_BIN_HOME}"];
  };

  # System packages (alphabetically organized in categories)
  environment.systemPackages = with pkgs; [
    # Base utilities
    git
    wget
    vim
    lsof
    htop
    bat
    bc
    eza
    fzf
    jq
    ripgrep
    fd
    starship
    stow
    tmux
    unzip
    zoxide
    tealdeer
    progress
    inxi
    fastfetch
    gzip

    # Development tools
    alejandra # Nix formatter
    ansible
    atac
    aider-chat
    bun
    cmake
    conda
    deadnix # Find dead Nix code
    devbox
    devenv
    diff-so-fancy
    entr
    gcc
    ghostty
    gnumake
    go
    home-manager
    micromamba
    mysql_jdbc
    neovim
    nh
    nil # Nix language server
    nixd
    nodejs_22
    pipx
    pkg-config
    pnpm
    poetry
    postman
    python3
    python312Packages.pandas
    python312Packages.seaborn
    python312Packages.matplotlib
    python312Packages.numpy
    rust-analyzer
    rustup
    statix # Lints and suggestions for Nix code
    sumneko-lua-language-server
    uv # Python package installer/resolver
    vscode

    # Languages and runtimes
    lua
    lua5_1
    luajitPackages.lua-lsp
    luarocks
    emmet-language-server

    # System tools
    acpi
    brightnessctl
    dig
    efibootmgr
    gparted
    gnome-tweaks
    kdePackages.partitionmanager
    pciutils
    psmisc
    isoimagewriter
    usbimager

    # Virtualization and containers
    distrobox
    docker
    gnome-boxes
    podman
    spice
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer

    # Wayland tools
    cliphist
    grimblast
    grim
    hyprcursor
    hyprland-qt-support
    hyprland-qtutils
    hyprlock
    hyprls
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprsunset
    hyprsysteminfo
    hyprutils
    hyprwayland-scanner
    imv
    nwg-displays
    nwg-look
    pyprland
    rofi-wayland
    slurp
    sway
    swaybg
    swaynotificationcenter
    swappy
    swww
    waybar
    wl-clipboard
    wl-clip-persist
    wlogout
    wlprop
    wlrctl
    wlsunset
    wofi
    wtype
    wpaperd

    # Audio/Video
    cava
    ffmpeg_6-full
    mpv
    obs-studio
    pamixer
    playerctl
    pwvucontrol
    sonusmix
    vlc
    wf-recorder

    # Graphics and design
    drawing
    imagemagick
    krita

    # Gaming
    bottles
    bubblewrap
    gamemode
    heroic
    lutris
    protontricks

    # Communication
    anydesk
    rustdesk
    telegram-desktop
    tunnelto
    webcord
    zoom-us

    # File management
    dua
    tokei
    sqlitebrowser
    tesseract
    xdg-utils
    xfce.thunar
    xfce.thunar-volman

    # Browsers
    brave
    chromium

    # Network tools
    blueman
    iwgtk
    motrix
    qbittorrent
    wgnord

    # Office and productivity
    libreoffice
    showtime

    # Appearance and customization
    aquamarine
    ags
    catppuccin-cursors.macchiatoTeal
    catppuccin-gtk
    catppuccin-kvantum
    comic-mono
    cool-retro-term
    dunst
    eww
    figlet
    fuzzel
    hyprgraphics
    kitty
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    lolcat
    numix-icon-theme-circle
    onefetch
    parabolic
    qt6.qtwayland
    themechanger
    tk
    wallust
    yad

    # NVIDIA and GPU tools
    cudaPackages.libcublas
    cudatoolkit
    lmstudio
    nvitop
    nvtopPackages.nvidia
    ollama-cuda
    onnxruntime

    # Specific hardware support
    lenovo-legion

    # Desktop environment components
    alacritty
    dbus
    eog
    flatpak
    geany
    gnomeExtensions.appindicator
    gnomeExtensions.nordvpn-quick-toggle
    gvfs
    gtk4
    keypunch
    libgcc
    libinput
    libinput-gestures
    libnotify
    lollypop
    netbeans
    poweralertd
    psi-notify
    sxhkd
    webkitgtk
    wmctrl
    wine64

    # Other tools
    glib
    moreutils
    mycli
    openssl
    tree
    vivid
    wayland-scanner.dev
  ];

  #############################################################################
  #                         LOCALE AND TIME SETTINGS                          #
  #############################################################################
  # Set timezone and locale
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  #############################################################################
  #                            USER CONFIGURATION                             #
  #############################################################################
  # Default shell for all users

  # Main user account configuration
  users.users.sanbid = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "sanbid";
    extraGroups = [
      "networkmanager"
      "libvirtd"
      "docker"
      "wheel" # sudo access
      "ydotool"
      "audio"
      "kvm"
    ];
  };

  # Additional group memberships
  users.extraGroups.vboxusers.members = ["sanbid"];
  users.groups.libvirtd.members = ["sanbid"];

  #############################################################################
  #                           SECURITY SETTINGS                               #
  #############################################################################
  security = {
    sudo.extraConfig = "sanbid ALL=(ALL:ALL) SETENV: ALL";
    rtkit.enable = true; # For real-time process priorities (audio)
  };

  # Allow root and sanbid to perform privileged Nix operations
  nix.settings.trusted-users = ["root" "sanbid"];

  #############################################################################
  #                           SERVICES CONFIGURATION                          #
  #############################################################################
  # Audio services
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Database
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # Display and desktop services
  services.displayManager.sddm.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"]; # Use NVIDIA drivers

    # Desktop environments
    desktopManager = {
      xfce.enable = true;
      gnome.enable = true;
      xterm.enable = true;
    };

    # Window managers
    windowManager = {
      bspwm.enable = true;
    };

    # Keyboard layout
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # DBUS and related services
  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [
      xfce.xfconf
    ];
  };

  # File system services
  services.gvfs.enable = true;

  # System services
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.sysprof.enable = true;
  services.udev.packages = with pkgs; [gnome-settings-daemon];
  services.kasmweb.enable = false; # Remote desktop service

  # Idle service for Hyprland
  services.hypridle.enable = true;

  # ML model serving
  services.ollama = {
    enable = true;
    acceleration = "cuda"; # Use NVIDIA GPU
  };

  # Systemd configurations
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=6s
  '';

  #############################################################################
  #                           PROGRAMS AND FEATURES                           #
  #############################################################################
  # Shell programs
  programs.zsh = {
    enable = true;
  };
  programs.fish.enable = true;

  # Desktop utilities
  programs.firefox.enable = true;
  programs.appimage.enable = true;
  programs.java.enable = true;
  programs.ydotool.enable = true;
  programs.virt-manager.enable = true;
  programs.dconf.enable = true;
  programs.hyprland.withUWSM = true;

  # XDG Portal for desktop integration
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Compatibility layer for dynamically linked programs
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Common libraries that might be needed
      stdenv.cc.cc.lib
      zlib
      glib
      gtk3
      libusb1
      udev
    ];
  };

  # SSH configuration
  programs.ssh.askPassword = lib.mkForce "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

  #############################################################################
  #                          HARDWARE CONFIGURATION                           #
  #############################################################################
  # Graphics and GPU settings
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
      ];
    };

    # NVIDIA specific configuration
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0"; # Bus ID for Intel GPU
        nvidiaBusId = "PCI:1:0:0"; # Bus ID for NVIDIA GPU
      };
    };
  };

  hardware.nvidia-container-toolkit.enable = true; # For NVIDIA in containers

  #############################################################################
  #                           VIRTUALIZATION                                  #
  #############################################################################
  virtualisation.podman = {
    enable = true;
  };

  #############################################################################
  #                                FONTS                                      #
  #############################################################################

  fonts = {
    fontconfig = {
      # Fixes pixelation
      antialias = true;

      # Fixes antialiasing blur
      hinting = {
        enable = true;
        style = "full"; # no difference
        autohint = true; # no difference
      };

      subpixel = {
        # Makes it bolder
        rgba = "rgb";
        lcdfilter = "default"; # no difference
      };
    };
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs;
      [
        nerd-fonts.jetbrains-mono
        nerd-fonts.daddy-time-mono
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
      ]
      ++ [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
      ];

    defaultFonts = {
      serif = ["Ubuntu" "Liberation Serif" "Vazirmatn"];
      sansSerif = ["Ubuntu" "Vazirmatn"];
      monospace = ["Ubuntu Mono"];
    };
  };

  #############################################################################
  #                               NIX SETTINGS                                #
  #############################################################################
  # Enable flakes and command features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Optimize the Nix store
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  # Set the Nix path to use the flake inputs
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Enable CUDA support for applicable packages
  nixpkgs.config.cudaSupport = true;

  # System state version (DO NOT CHANGE after install)
  system.stateVersion = "24.05";
}
