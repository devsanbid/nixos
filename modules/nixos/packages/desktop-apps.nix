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


    jetbrains.idea
    # ── Status bars / Launchers (not managed by HM) ─────────
    eww
    dmenu
    wofi

    yazi

    windsurf

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
    wl-mirror

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
    anyrun

    alacritty
    btop
    fuzzel
    cava

    lmstudio
    nix-search-cli

  # viber
  (viber.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      rm -f $out/opt/viber/lib/libxml2.so.2
      ln -s "${pkgs.lib.getLib pkgs.libxml2}/lib/libxml2.so" "$out/opt/viber/lib/libxml2.so.2"
      
      # Fix Qt plugin collision with Hyprland and system Qt
      wrapProgram $out/bin/viber \
        --unset QT_QUICK_CONTROLS_STYLE \
        --unset QT_QPA_PLATFORMTHEME \
        --unset QML2_IMPORT_PATH \
        --unset QT_WAYLAND_DISABLE_WINDOWDECORATION
    '';
  }))
  ];
}
