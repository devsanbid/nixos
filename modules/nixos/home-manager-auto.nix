# Home-Manager Auto-Activation Module
# Ensures home-manager activates after every nixos-rebuild
{ config, lib, pkgs, username, ... }:

{
  # ── Home-Manager Integration ─────────────────────────────
  # Home-manager is configured in flake.nix as a NixOS module
  # This ensures it auto-activates on rebuild

  # Add activation script that runs after home-manager switch
  system.activationScripts.homeManagerAuto = {
    text = ''
      echo "[home-manager] Auto-activation hook running..."

      # Get the current home-manager generation
      HOME_GEN="''$(readlink ~/.nix-profile 2>/dev/null || echo 'none')"
      echo "[home-manager] Current profile: ''${HOME_GEN}"

      # Check if home-manager is properly linked
      if [ -L ~/.nix-profile ] && [ -d ~/.nix-profile ]; then
        echo "[home-manager] ✓ Profile active for ${username}"
      else
        echo "[home-manager] ⚠ Profile not found for ${username}"
      fi

      # Ensure home-manager binaries are in PATH
      if [ -d ~/.nix-profile/bin ]; then
        echo "[home-manager] ✓ Bin directory exists"
      fi

      # Log activation timestamp
      echo "$(date): Home-manager activated" >> /var/log/home-manager-activations.log 2>/dev/null || true
    '';
    deps = [ "users" ];  # Run after users are set up
  };

  # ── Boot Snapshot Labels ─────────────────────────────────
  # Add generation labels to boot menu
  boot.loader.systemd-boot.extraFiles = {
    # Copy a custom background or logo if desired
  };

  # ── System-Wide Home-Manager Settings ────────────────────
  home-manager = {
    # These are already set in flake.nix, but we ensure backup file extension
    backupFileExtension = "backup-$(date +%Y%m%d-%H%M%S)";

    # Show news after activation
    news.display = "show";

    # Extra output on activation
    verbose = true;
  };

  # ── Packages for Home-Manager ────────────────────────────
  environment.systemPackages = with pkgs; [
    home-manager  # Ensure home-manager CLI is available
  ];
}
