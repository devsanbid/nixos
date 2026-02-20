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
}
