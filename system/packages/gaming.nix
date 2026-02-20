# Gaming & Wine
{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # bottles - Use Flatpak version instead: flatpak install flathub com.usebottles.bottles
    bubblewrap
    gamemode
    heroic
    lutris
    # protontricks
    # wineWowPackages.waylandFull
    warehouse
    # wine64
  ];
}
