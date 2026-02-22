# Multimedia — audio visualizer, players, screen capture
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cava
    pamixer
    playerctl
    mpv
    vlc
    wf-recorder
    imv
    imagemagick
    eog
    drawing
    cheese
    lollypop
  ];
}
