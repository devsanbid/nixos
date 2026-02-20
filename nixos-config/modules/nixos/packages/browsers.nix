# Browsers & internet apps
{ pkgs, zen-browser, ... }:

{
  environment.systemPackages = with pkgs; [
    ungoogled-chromium
    brave
    firefox-bin
    vivaldi
    zen-browser.packages.${pkgs.system}.default

    telegram-desktop
    anydesk
    motrix
    qbittorrent
    tunnelto
    wgnord
  ];
}
