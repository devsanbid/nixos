# HOME: Work — DMS, waybar, full dev tools
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
    ];
  };

  # ── Work Packages ─────────────────────────────────────────
  home.packages = with pkgs; [
    wf-recorder
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs obs-pipewire-audio-capture obs-vkcapture obs-vaapi
      ];
    })
  ];
}
