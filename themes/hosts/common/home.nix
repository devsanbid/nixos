# Shared Home-Manager defaults — used by all hosts
{ config, lib, pkgs, username, ... }:

{
  imports = [
    ../../modules/home
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";

  # ── Desktop Compositors ───────────────────────────────────
  modules.home.desktop = {
    hyprland.enable = lib.mkDefault true;
    niri.enable = lib.mkDefault true;
  };

  # ── Shell & Terminal ──────────────────────────────────────
  modules.home.shell = {
    fish.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
  };

  modules.home.terminal = {
    kitty.enable = lib.mkDefault true;
    alacritty.enable = lib.mkDefault true;
  };

  # ── Desktop Apps ──────────────────────────────────────────
  modules.home.apps = {
    waybar.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    fuzzel.enable = lib.mkDefault true;
    dunst.enable = lib.mkDefault true;
    swaync.enable = lib.mkDefault true;
    wlogout.enable = lib.mkDefault true;
    btop.enable = lib.mkDefault true;
    cava.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true;
    swappy.enable = lib.mkDefault true;
    wpaperd.enable = lib.mkDefault true;
  };

  # ── Development ───────────────────────────────────────────
  modules.home.dev = {
    git.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
    scripts.enable = lib.mkDefault true;
  };

  # ── Theming ───────────────────────────────────────────────
  modules.home.theming = {
    wallust.enable = lib.mkDefault true;
    themes.enable = lib.mkDefault true;
    wallpapers.enable = lib.mkDefault true;
    hyprland-rice.enable = lib.mkDefault true;
    ags.enable = lib.mkDefault true;
    qt.enable = lib.mkDefault true;
  };

  # ── Common Packages ───────────────────────────────────────
  home.packages = with pkgs; [
    discord
    papirus-folders
    zafiro-icons
    rustc
  ];

  programs.home-manager.enable = true;
}
