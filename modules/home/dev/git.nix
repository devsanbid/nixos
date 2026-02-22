# Git — global config, aliases, delta diff
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.dev.git;
in
{
  options.modules.home.dev.git = {
    enable = lib.mkEnableOption "Git version control";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "devsanbid";
          email = "devsanbid@gmail.com";
        };
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        core.editor = "nvim";
        url."ssh://git@github.com/".insteadOf = "https://github.com/";
        alias = {
          co = "checkout";
          br = "branch";
          ci = "commit";
          st = "status";
          unstage = "reset HEAD --";
          last = "log -1 HEAD";
          lg = "log --oneline --graph --decorate --all";
          wip = "!git add -A && git commit -m 'wip'";
        };
      };
    };

    programs.delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "Catppuccin Mocha";
      };
    };

    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };
  };
}
