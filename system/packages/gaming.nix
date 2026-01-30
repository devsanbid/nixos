# Gaming & Wine
{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    bottles
    bubblewrap
    gamemode
    heroic
    lutris
    protontricks
    wineWowPackages.waylandFull
    warehouse
    wine64
  ];
}
