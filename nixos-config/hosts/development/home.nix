# ╔══════════════════════════════════════════════════════════════╗
# ║  HOME: Development — Home-Manager Configuration             ║
# ║  KDE-focused, no waybar, no DMS, lean setup                ║
# ╚══════════════════════════════════════════════════════════════╝
{ config, lib, pkgs, inputs, hostname, ... }:

{
  imports = [
    ../../modules/home
  ];

  home.username = "sanbid";
  home.homeDirectory = "/home/sanbid";
  home.stateVersion = "24.05";

  # ── Desktop Compositors ───────────────────────────────────
  modules.home.desktop = {
    hyprland.enable = true;
    niri.enable = true;
  };

  # ── Shell & Terminal ──────────────────────────────────────
  modules.home.shell = {
    fish.enable = true;
    zsh.enable = true;
    starship.enable = true;
    tmux.enable = true;
  };

  modules.home.terminal = {
    kitty.enable = true;
    alacritty.enable = true;
  };

  # ── Desktop Apps ──────────────────────────────────────────
  modules.home.apps = {
    waybar.enable = false;    # KDE has its own panel
    rofi.enable = true;
    fuzzel.enable = true;
    dunst.enable = true;
    swaync.enable = true;
    wlogout.enable = true;
    btop.enable = true;
    cava.enable = true;
    fastfetch.enable = true;
    swappy.enable = true;
    wpaperd.enable = true;
  };

  # ── Development ───────────────────────────────────────────
  modules.home.dev = {
    git.enable = true;
    neovim.enable = true;
    scripts.enable = true;
  };

  # ── Theming ───────────────────────────────────────────────
  modules.home.theming = {
    wallust.enable = true;
    themes.enable = true;
    wallpapers.enable = true;
    hyprland-rice.enable = true;
    ags.enable = true;
    qt.enable = true;
  };

  # ── No DMS for development (KDE-focused) ──────────────────

  # ── Dev Packages ──────────────────────────────────────────
  home.packages = with pkgs; [
    discord
    papirus-folders
    zafiro-icons
    rustc
  ];

  programs.home-manager.enable = true;
}
