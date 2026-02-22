# HOME: Personal — DMS, gaming, multimedia
{ pkgs, ... }:

{
  imports = [ ../common/home.nix ];

  # ── DankMaterialShell ─────────────────────────────────────
  programs.dank-material-shell.enable = true;
  programs.dsearch = {
    enable = true;
    config.index_paths = [
      { path = "~"; max_depth = 5; exclude_hidden = true;
        exclude_dirs = [ "node_modules" ".git" "target" "venv" ".cache" ".local" ".mozilla" ".config" "snap" "go" ]; }
      { path = "~/.dotfiles"; max_depth = 6; exclude_hidden = false;
        exclude_dirs = [ "result" ".git" ]; }
      { path = "~/.config"; max_depth = 4; exclude_hidden = true;
        exclude_dirs = [ "chromium" "BraveSoftware" "Code" "discord" ]; }
    ];
  };

  # ── Personal Packages ─────────────────────────────────────
  home.packages = with pkgs; [
    wf-recorder
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs obs-pipewire-audio-capture obs-vkcapture obs-vaapi
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
