# Common NixOS configuration shared by all hosts
{ config, lib, pkgs, inputs, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  # ── Kernel ────────────────────────────────────────────────
  # XanMod Stable — BBR3, BORE scheduler, NVIDIA compatible
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;

  # ── Hostname (set per-host, but needed here for networking) ─
  networking.hostName = lib.mkDefault hostname;

  # ── Stylix (global theming) ───────────────────────────────
  stylix = {
    enable = true;
    autoEnable = false;     # We manage themes ourselves — disable auto-theming
    polarity = "dark";
    image = ../../config/wallpapers/1.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
}
