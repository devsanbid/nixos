# Graphics & Multimedia
{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # Audio
    cava
    pamixer
    playerctl

    # Video
    mpv
    vlc
    wf-recorder

    # Image viewers & editors
    imv
    imagemagick
    eog
    drawing
    cheese

    # Music
    lollypop
  ];
}
