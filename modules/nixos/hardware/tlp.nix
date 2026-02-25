# TLP power management — Lenovo Legion 5 i9-14900HX + RTX 4070
{ config, pkgs, lib, ... }:
{
  services.power-profiles-daemon.enable = false;
  powerManagement.enable = false;
  services.upower = lib.mkForce {
    enable = true;
    noPollBatteries = false;
  };
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC  = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_BOOST_ON_AC  = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC  = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 40;
      CPU_MIN_PERF_ON_AC  = 0;
      CPU_MAX_PERF_ON_AC  = 100;
      PCIE_ASPM_ON_BAT = "powersupersave";
      PCIE_ASPM_ON_AC  = "default";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_ON_AC  = "on";
      WIFI_PWR_ON_BAT = "on";
      WIFI_PWR_ON_AC  = "off";

      # Lenovo Legion conservation mode (~60% charge limit)
      START_CHARGE_THRESH_BAT0 = 0;
      STOP_CHARGE_THRESH_BAT0  = 1;

      DISK_DEVICES = "nvme0n1";
      DISK_APM_LEVEL_ON_BAT    = "128";
      DISK_APM_LEVEL_ON_AC     = "254";
      DISK_IOSCHED_ON_BAT      = "mq-deadline";
      DISK_IOSCHED_ON_AC       = "none";
      DISK_IDLE_SECS_ON_BAT = 2;
      DISK_IDLE_SECS_ON_AC  = 0;
      USB_AUTOSUSPEND = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_ON_AC  = 0;
    };
  };
}
