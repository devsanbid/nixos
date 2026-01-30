# Desktop Environment & Window Manager Tools
{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    # Hyprland ecosystem
    ags
    aquamarine
    hyprgraphics
    hyprcursor
    hyprlock
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprsunset
    hyprutils
    hyprwayland-scanner
    hyprls
    hyprland-qt-support
    hyprland-protocols

    # Bars & Menus
    waybar
    eww
    rofi
    fuzzel
    dmenu
    wofi

    # Terminals
    ghostty
    kitty
    cool-retro-term

    # Notifications
    dunst

    # Wallpaper & Themes
    swww
    swaybg
    hyprpaper
    nwg-look
    wallust

    # Screenshot & Recording
    slurp
    swappy

    # Wayland utilities
    wlogout
    wl-clipboard
    wl-clip-persist
    wlprop
    wlrctl
    wlsunset
    wtype
    wmctrl
    quickshell

    # Pyprland - Hyprland plugin system
    pyprland

    # Network/Bluetooth applets
    networkmanagerapplet  # nm-applet

    # Compositors
    picom
    sway

    # KDE integration
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
  ];
}
