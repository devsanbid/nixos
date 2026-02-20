# Desktop services — D-Bus broker, GNOME keyring, Ollama
{ pkgs, ... }:

{
  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [ xfce.xfconf ];
  };

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
  };
}
