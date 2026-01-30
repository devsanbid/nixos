# Browsers & Communication Apps
{ pkgs, zen-browser, ... }: {

  environment.systemPackages = with pkgs; [
    # Browsers
    ungoogled-chromium
    brave
    firefox-bin
    vivaldi
    zen-browser.packages.${pkgs.system}.default

    # Communication
    telegram-desktop
    anydesk

    # Downloads
    motrix
    qbittorrent

    # VPN & Network
    tunnelto
    wgnord
  ];
}
