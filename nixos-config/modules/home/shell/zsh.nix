# Zsh — Oh-My-Zsh, autosuggestions, syntax highlighting
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.shell.zsh;
in
{
  options.modules.home.shell.zsh = {
    enable = lib.mkEnableOption "Zsh shell";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "fzf" "z" "docker" "docker-compose" "jsontools" ];
      };

      initExtra = ''
        # Source custom zshrc if exists
        if [ -f ~/.config/.zshrc ]; then
          source ~/.config/.zshrc
        fi

        # ── Modern tool integrations ───────────────────────
        eval "$(starship init zsh)"
        eval "$(zoxide init zsh)"
      '';

      shellAliases = {
        ls = "eza --icons --group-directories-first";
        la = "eza -la --icons --group-directories-first";
        ll = "eza -l --icons --group-directories-first";
        cat = "bat --style=auto";
        vim = "nvim";
        rebuild = "nh os switch";
        lg = "lazygit";
        ff = "fastfetch";
      };
    };
  };
}
