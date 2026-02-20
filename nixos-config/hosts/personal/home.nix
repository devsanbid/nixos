# ╔══════════════════════════════════════════════════════════════╗
# ║  HOME: Personal — Home-Manager Configuration                ║
# ║  Full Hyprland + DMS + Waybar + all programs + gaming       ║
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
    waybar.enable = true;     # Personal uses waybar
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

  # ── DankMaterialShell (Personal gets DMS) ─────────────────
  programs.dank-material-shell.enable = true;
  programs.dsearch = {
    enable = true;
    config = {
      index_paths = [
        {
          path = "~";
          max_depth = 5;
          exclude_hidden = true;
          exclude_dirs = [ "node_modules" ".git" "target" "venv" ".cache" ".local" ".mozilla" ".config" "snap" "go" ];
        }
        {
          path = "~/.dotfiles";
          max_depth = 6;
          exclude_hidden = false;
          exclude_dirs = [ "result" ".git" ];
        }
        {
          path = "~/.config";
          max_depth = 4;
          exclude_hidden = true;
          exclude_dirs = [ "chromium" "BraveSoftware" "Code" "discord" ];
        }
      ];
    };
  };

  # ── Personal Packages ─────────────────────────────────────
  home.packages = with pkgs; [
    discord
    papirus-folders
    zafiro-icons
    rustc
    wf-recorder
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs
        obs-pipewire-audio-capture
        obs-vkcapture
        obs-vaapi
      ];
    })
  ];

  # ── Personal Extras ───────────────────────────────────────
  xdg.desktopEntries.netbeans = {
    name = "netbeans 2";
    icon = "netbeans";
    genericName = "Integrated Development Environment";
    exec = "netbeans --fontsize 24";
    categories = [ "Development" ];
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };

  home.file.".config/kwalletrc".text = ''
    [Wallet]
    Enabled=false
    First Use=false
  '';

  programs.home-manager.enable = true;
}
