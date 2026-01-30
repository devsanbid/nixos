# System services configuration
{ pkgs, ... }: {

  # D-Bus
  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [ xfce.xfconf ];
  };

  # File systems
  services.gvfs.enable = true;

  # Profiling
  services.sysprof.enable = true;

  # Udev rules
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Remote/VM connectivity
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.kasmweb.enable = false;

  # Ollama AI
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };
}
