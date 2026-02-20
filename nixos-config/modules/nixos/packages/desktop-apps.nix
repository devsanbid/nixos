# Desktop applications — Hyprland ecosystem, launchers, terminals
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ── Hyprland ecosystem ──────────────────────────────────
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

    # ── Status bars / Launchers ─────────────────────────────
    waybar
    eww
    rofi
    fuzzel
    dmenu
    wofi

    # ── Terminals ───────────────────────────────────────────
    ghostty
    kitty
    cool-retro-term

    # ── Notifications ───────────────────────────────────────
    dunst

    # ── Wallpaper / Theming ─────────────────────────────────
    swww
    swaybg
    hyprpaper
    nwg-look
    wallust

    # ── Screenshot / Clipboard ──────────────────────────────
    slurp
    swappy
    wl-clipboard
    wl-clip-persist

    # ── Wayland utilities ───────────────────────────────────
    wlogout
    wlprop
    wlrctl
    wlsunset
    wtype
    wmctrl

    # ── Shell extensions ────────────────────────────────────
    quickshell
    pyprland

    # ── Tray / network ──────────────────────────────────────
    networkmanagerapplet
    picom
    sway
  ];
}
