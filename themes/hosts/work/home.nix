# HOME: Work — DMS, waybar, full dev tools
{ pkgs, ... }:

{
  imports = [ ../common/home.nix ];


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
