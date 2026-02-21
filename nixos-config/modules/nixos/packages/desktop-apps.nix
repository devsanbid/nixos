# Desktop applications — Hyprland ecosystem, Wayland utilities
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

    # ── Status bars / Launchers (not managed by HM) ─────────
    eww
    dmenu
    wofi

    # ── Terminals (not managed by HM) ───────────────────────
    ghostty
    cool-retro-term

    # ── Wallpaper / Theming ─────────────────────────────────
    swww
    swaybg
    nwg-look

    # ── Screenshot / Clipboard ──────────────────────────────
    slurp
    wl-clipboard
    wl-clip-persist

    # ── Wayland utilities ───────────────────────────────────
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
  ];
}
