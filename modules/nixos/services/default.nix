# Desktop services — D-Bus broker, GNOME keyring, Ollama
{ pkgs, ... }:

{
  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [ dconf xfconf ];
  };

  programs.dconf.enable = true;

  services.gvfs.enable = true;
  services.sysprof.enable = true;
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # ── GNOME Keyring ─────────────────────────────────────────
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # ── QEMU Guest (for VM testing) ───────────────────────────
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # ── AI: Ollama with CUDA ──────────────────────────────────
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
     environmentVariables = {
    "__NV_PRIME_RENDER_OFFLOAD" = "1";
    "__NV_PRIME_RENDER_OFFLOAD_PROVIDER" = "NVIDIA-G0";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "__VK_LAYER_NV_optimus" = "PRIME";
    };
  };
  # services.open-webui.enable = true;
}
