# User scripts — symlinked to ~/.local/bin
{ config, lib, ... }:

let
  cfg = config.modules.home.dev.scripts;
in
{
  options.modules.home.dev.scripts = {
    enable = lib.mkEnableOption "User scripts (~/.local/bin)";
  };

  config = lib.mkIf cfg.enable {
    home.file.".local/bin" = {
      source = ../../../script;
      recursive = true;
      executable = true;
      force = true;
    };
  };
}
