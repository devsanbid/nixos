# Starship prompt — minimal, fast, cross-shell
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.shell.starship;
in
{
  options.modules.home.shell.starship = {
    enable = lib.mkEnableOption "Starship prompt";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      settings = {
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_status"
          "$nix_shell"
          "$cmd_duration"
          "$line_break"
          "$character"
        ];

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold green)";
        };

        directory = {
          truncation_length = 3;
          truncation_symbol = "…/";
          style = "bold cyan";
        };

        git_branch = {
          symbol = " ";
          style = "bold purple";
        };

        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold red";
        };

        nix_shell = {
          symbol = " ";
          format = "via [$symbol$state]($style) ";
          style = "bold blue";
        };

        cmd_duration = {
          min_time = 2000;
          format = "took [$duration]($style) ";
          style = "bold yellow";
        };

        # ── Disable noisy modules ───────────────────────────
        nodejs.disabled = true;
        python.disabled = true;
        rust.disabled = true;
        golang.disabled = true;
        java.disabled = true;
        lua.disabled = true;
        package.disabled = true;
      };
    };
  };
}
