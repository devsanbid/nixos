# Network — NetworkManager, DNS, WiFi
{ ... }:

{
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      dns = "none";
    };

    firewall.allowedTCPPorts = [ 443 ];
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
  };

  networking.interfaces.wlan0.mtu = 1400;
}
