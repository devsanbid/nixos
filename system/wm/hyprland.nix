{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # Import wayland config
  imports = [
    ./wayland.nix
  ];

  # Enable Hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1"; # Enable Display Manager

  # services.greetd = {
  #     enable = true;
  #     settings = {
  #         default_session = {
  #             command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
  #             user = "sanbid";
  #         };
  #     };
  # };

  # programs.regreet.enable = true;
  # programs.regreet.settings = {
  #   background = {
  #     path = ../../config/hypr/wallpapers/arch.png;
  #     fit = "Fill";
  #   };
  #
  #   GTK = {
  #     application_prefer_dark_theme = true;
  #     theme_name = lib.mkForce "aphelion";
  #     font_name = lib.mkForce "monofur Nerd Font 20";
  #   };
  #   default_session = {
  #     command = "${pkgs.hyprland}/bin/hyprland";
  #   };
  # };

  environment.systemPackages = with pkgs; [
    # greetd.tuigreet
  ];
}
