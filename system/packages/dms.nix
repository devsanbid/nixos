# DankMaterialShell dependencies and integrations
{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # === Core DMS Dependencies ===
    quickshell              # Shell framework (required)
    
    # === Dynamic Theming ===
    matugen                 # Material Design color palette generation
    # dank16 is built into DMS
    
    # === System Monitoring ===
    # dgop is provided by DMS flake
    lm_sensors              # Hardware sensors
    
    # === Clipboard ===
    wl-clipboard            # Wayland clipboard
    cliphist                # Clipboard history
    
    # === Audio Visualizer ===
    cava                    # Audio visualizer widget
    
    # === Calendar Integration ===
    khal                    # Calendar CLI (for calendar widget)
    vdirsyncer              # Calendar sync
    
    # === DDC/CI Monitor Control ===
    ddcutil                 # DDC monitor backlight control
    i2c-tools               # I2C utilities for DDC
    
    # === Qt Multimedia ===
    qt6.qtmultimedia        # System sound feedback
    
    # === Fingerprint (Optional) ===
    fprintd                 # Fingerprint authentication
    
    # === Additional Theming Tools ===
    # gradience removed upstream - use adw-gtk3 directly
    adw-gtk3                # GTK3 theme for libadwaita
    
    # === System Services ===
    accountsservice         # User account management
    power-profiles-daemon   # Power management
    networkmanager          # Network management
    bluez                   # Bluetooth
    blueman                 # Bluetooth manager
    
    # === Media Integration ===
    playerctl               # MPRIS media controls
    
    # === Weather ===
    wttrbar                 # Weather widget data
    
    # === File Search (danksearch alternative) ===
    fd                      # Fast file search
    mlocate                 # File locate
    plocate                 # Fast locate
    
    # === System Tray Support ===
    libappindicator-gtk3    # App indicators
    
    # === Polkit ===
    polkit_gnome            # Polkit agent (fallback)
  ];

  # Enable services needed for DMS
  services.accounts-daemon.enable = true;
  
  # Enable DDC/CI for monitor control
  hardware.i2c.enable = true;
  
  # Fingerprint service
  services.fprintd.enable = true;
}
