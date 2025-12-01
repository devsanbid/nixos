{ config, lib, pkgs, inputs, zen-browser, ... }: {
  # Imports: Only essential local modules
  imports = [
    ./hardware-configuration.nix
    ./system
  ];

  #############################################################################
  #                          BOOT & NIX CONFIGURATION                         #
  #############################################################################
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    cudaSupport = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];


  boot.kernelModules = [ "acpi_ec" "wmi" "ec_sys" "thinkpad_acpi" ];
  boot.extraModulePackages = with pkgs; [
    linuxKernel.packages.linux_6_12.lenovo-legion-module
  ];

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  # Kernel parameters for NVIDIA
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # System performance tweaks
  services.fstrim.enable = true;
  services.preload.enable = true;
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
    "vm.vfs_cache_pressure" = 50;
  };

  # Nix Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.settings.trusted-users = [ "root" "sanbid" ];
  system.stateVersion = "24.05";


  #############################################################################
  #                             NETWORKING & VIRTUALIZATION                   #
  #############################################################################
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      dns = "none";
    };
    firewall.allowedTCPPorts = [ 443 ];
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
  };

  networking.interfaces.wlan0.mtu = 1400;

  # Virtualization
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
        addNetworkInterface = true;
        enableKvm = false; # This is key!
      };
      guest.enable = true;
      guest.dragAndDrop = true;
    };
  };
  users.extraGroups.vboxusers.members = [ "sanbid" ];

  # Remote Connectivity
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.kasmweb.enable = false;

  #############################################################################
  #                             HARDWARE CONFIGURATION                        #
  #############################################################################
  hardware.enableRedistributableFirmware = true;
  hardware.nvidia-container-toolkit.enable = true; # For NVIDIA in containers
  services.power-profiles-daemon.enable = true;
  services.usbmuxd.enable = true; # For Apple device support
  security.rtkit.enable = true; # For real-time process priorities (audio)

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
      ];
    };

    nvidia = {
      modesetting.enable = true;
      open = false;
      powerManagement.enable = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        sync.enable = false;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };

  #############################################################################
  #                             AUDIO & DISPLAY SERVICES                      #
  #############################################################################
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true; # KDE Plasma 6
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    desktopManager = {
      xfce.enable = true;
      cinnamon.enable = true;
      xterm.enable = true;
    };

    windowManager = {
      bspwm.enable = true;
      dwm.enable = true;
      awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
          awesome-wm-widgets
        ];
      };
    };

    xkb = { layout = "us"; variant = ""; };
  };

  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [ xfce.xfconf ];
  };
  services.gvfs.enable = true;
  services.sysprof.enable = true;
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Hyprland specific
  services.hypridle.enable = true;

  #############################################################################
  #                             USER & SHELL CONFIGURATION                    #
  #############################################################################
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users = {
    sanbid = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "sanbid";
      extraGroups = [
        "networkmanager"
        "kvm"
        "vboxusers"
        "adbusers"
        "libvirtd"
        "docker"
        "wheel"
        "ydotool"
        "audio"
      ];
    };
    sandesh = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "real users";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };
  users.groups.libvirtd.members = [ "sanbid" ];

  security.sudo.extraConfig = "sanbid ALL=(ALL:ALL) SETENV: ALL";

  programs = {
    zsh.enable = true;
    fish.enable = true;
    adb.enable = true;
    steam.enable = true;
    appimage.enable = true;
    dconf.enable = true;
    ydotool.enable = true;

    java = { enable = true; package = pkgs.jdk; };
    ssh.askPassword = lib.mkForce "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

    nix-ld = {
      enable = true;
      libraries = with pkgs; [ stdenv.cc.cc.lib zlib glib gtk3 libusb1 udev ];
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "$HOME/.dotfiles";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  #############################################################################
  #                          ENVIRONMENT VARIABLES                            #
  #############################################################################
  environment.etc."usr/bin/which".source = "${pkgs.which}/bin/which";

  environment.sessionVariables = rec {
    # XDG base directories
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";

    # PATH & RUST
    PATH = [ "${XDG_BIN_HOME}" "$HOME/.cargo/bin" ];
    # RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

    # GPU/CUDA
    # CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";

    # GTK/Development
    GDK_SCALE = "1";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.webkitgtk_4_1.dev}/lib/pkgconfig:${pkgs.libsoup_3.dev}/lib/pkgconfig:${pkgs.gtk4.dev}/lib/pkgconfig:${pkgs.gtk3.dev}/lib/pkgconfig:${pkgs.pango.dev}/lib/pkgconfig:${pkgs.cairo.dev}/lib/pkgconfig:${pkgs.gdk-pixbuf.dev}/lib/pkgconfig:${pkgs.glib.dev}/lib/pkgconfig:${pkgs.atk.dev}/lib/pkgconfig:${pkgs.gobject-introspection.dev}/lib/pkgconfig";
  };

  #############################################################################
  #                              SYSTEM PACKAGES                              #
  #############################################################################
  environment.systemPackages = with pkgs; [
    # --- 1. System & Hardware Tools ---
    acpi
    brightnessctl
    dmidecode
    efibootmgr
    gnome-tweaks
    gparted
    inxi
    isoimagewriter
    kdePackages.partitionmanager
    lenovo-legion
    lsof
    pciutils
    psmisc
    sbctl
    testdisk
    testdisk-qt
    tree
    udev
    usbimager
    woeusb-ng
    wirelesstools

    # --- 2. Browsers & Communication ---
    anydesk
    brave
    chromium
    # ferdium
    motrix
    qbittorrent
    telegram-desktop
    tunnelto
    webcord
    wgnord
    # zoom-us
    zen-browser.packages.${pkgs.system}.default

    # --- 3. Desktop Environments & Window Managers ---
    ags
    aquamarine
    dmenu
    dunst
    eww
    fuzzel
    ghostty
    hyprgraphics
    hyprcursor
    hyprlock
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprsunset
    hyprutils
    hyprwayland-scanner
    kitty
    nwg-look
    picom
    rofi
    slurp
    sway
    swaybg
    swww
    waybar
    wlogout
    wofi
    wmctrl

    # --- 4. Development & Build Tools ---
    # aider-chat
    alejandra
    # android-studio
    ansible
    atac
    bun
    cargo
    clang
    cmake
    conda
    deadnix
    devbox
    diff-so-fancy
    entr
    gcc
    go
    gradle
    home-manager
    jetbrains.idea-community-bin
    jdk25
    kotlin
    lua-language-server
    luajitPackages.lua-lsp
    luarocks
    lua
    lua5_1
    meson
    mysql_jdbc
    neovim
    nh
    nil
    ninja
    nixd
    niv
    nodejs_22
    nodemon
    pipx
    pnpm
    postman
    python3
    # rustup
    statix
    typescript-language-server
    uv
    # vscode

    # --- 5. Virtualization & Container Tools ---
    distrobox
    docker
    gnome-boxes
    podman
    spice
    spice-gtk
    spice-protocol
    virt-viewer

    # --- 6. Graphics & Multimedia ---
    cava
    cheese
    drawing
    # ffmpeg.dev
    # ffmpeg_6-full
    imv
    imagemagick
    # krita
    mpv
    # obs-studio
    pamixer
    playerctl
    swappy
    vlc
    wf-recorder

    # --- 7. Gaming & Wine ---
    bottles
    bubblewrap
    gamemode
    heroic
    hyprland-qt-support
    hyprland-protocols
    lutris
    protontricks
    wineWowPackages.waylandFull
    warehouse
    wine64
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default

    # --- 8. Data & Database Tools ---
    # mongodb
    # mongosh
    mycli
    pgadmin4
    pgcli
    postgresql
    (rstudioWrapper.override {
      packages = with pkgs.rPackages; [
        ggplot2
        dplyr
        xts
        tidyverse
        randomForest
        snakecase
      ];
    })
    sqlitebrowser

    # --- 9. Productivity & Office ---
    code-cursor
    eog
    geany
    # glow
    kdePackages.kbackup
    kdePackages.kdevelop
    kdePackages.krdc
    kdePackages.kruler
    kdePackages.ktimer
    kdePackages.krecorder
    keypunch
    libqalculate
    libreoffice
    lollypop
    netbeans
    onlyoffice-desktopeditors
    pandoc
    pipeline
    showtime
    tesseract
    xfce.thunar
    xfce.thunar-volman

    # --- 10. Libraries & Development Headers (GTK/Webkit) ---
    atk
    atk.dev
    cairo
    cairo.dev
    glib
    glib.dev
    gdk-pixbuf
    gdk-pixbuf.dev
    gobject-introspection
    gobject-introspection.dev
    gtk3
    gtk3.dev
    gtk4
    gtk4.dev
    libadwaita
    libappindicator-gtk3
    librsvg
    librsvg.dev
    libsoup_3.dev
    openssl
    pango
    pango.dev
    pkg-config
    qt6.qtwayland
    webkitgtk_4_1
    webkitgtk_4_1.dev

    # --- 11. Command Line Utilities ---
    bat
    bc
    eza
    fd
    figlet
    fzf
    git
    gzip
    htop
    jq
    wirelesstools
    lazygit
    lolcat
    moreutils
    pastel
    progress
    ripgrep
    starship
    stow
    tmux
    unzip
    vivid
    wget
    yarn
    zoxide
    fastfetch
    tealdeer

    # --- 12. GPU/ML/AI & System Modules ---
    # cudaPackages.libcublas
    # cudatoolkit
    # llama-cpp

    # --- 13. Mobile & Apple Support ---
    scrcpy
    libimobiledevice
    ifuse

    # --- 14. Gnome Extensions (Keep these together) ---
    gnomeExtensions.appindicator
    gnomeExtensions.nordvpn-quick-toggle
    gvfs

    # --- 15. Miscellaneous ---
    cool-retro-term
    kdePackages.kde-gtk-config
    lact
    ocs-url
    poweralertd
    psi-notify
    tk
    wallust
    yad
    xdg-utils
    wl-clipboard
    wl-clip-persist
    wlprop
    wlrctl
    wlsunset
    wtype
    hyprls
  ];

  #############################################################################
  #                                FONTS                                      #
  #############################################################################

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      comic-mono
      # Nerd Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.noto
      nerd-fonts.monofur
      nerd-fonts.mononoki
      nerd-fonts.iosevka
      nerd-fonts.sauce-code-pro
      nerd-fonts.victor-mono
      nerd-fonts.zed-mono
      nerd-fonts.go-mono
      nerd-fonts.commit-mono
    ];
  };
}
