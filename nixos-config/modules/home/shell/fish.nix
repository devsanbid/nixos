# Fish shell — vi bindings, zoxide, starship, modern aliases
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.shell.fish;
in
{
  options.modules.home.shell.fish = {
    enable = lib.mkEnableOption "Fish shell";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        # ── Disable greeting ────────────────────────────────
        set fish_greeting ""

        # ── Vi key bindings ─────────────────────────────────
        fish_vi_key_bindings

        # ── Zoxide ──────────────────────────────────────────
        zoxide init fish | source

        # ── Vivid LS_COLORS ─────────────────────────────────
        set -gx LS_COLORS (vivid generate catppuccin-mocha)

        # ── Starship prompt ─────────────────────────────────
        starship init fish | source

        # ── Environment ─────────────────────────────────────
        set -gx EDITOR nvim
        set -gx VISUAL nvim
        set -gx OLLAMA_HOST "http://127.0.0.1:11434"
        fish_add_path $HOME/.cargo/bin
        fish_add_path $HOME/.bun/bin
        fish_add_path $HOME/.local/bin
      '';

      shellAliases = {
        # ── Modern replacements ─────────────────────────────
        ls = "eza --icons --group-directories-first";
        la = "eza -la --icons --group-directories-first";
        ll = "eza -l --icons --group-directories-first";
        lt = "eza --tree --icons --level=2";
        cat = "bat --style=auto";
        grep = "rg";
        find = "fd";

        # ── Navigation ──────────────────────────────────────
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";

        # ── Editor ──────────────────────────────────────────
        vim = "nvim";
        vi = "nvim";
        v = "nvim";

        # ── Git shortcuts ───────────────────────────────────
        g = "git";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline --graph";
        gs = "git status";
        gd = "git diff";
        lg = "lazygit";

        # ── NixOS ───────────────────────────────────────────
        rebuild = "nh os switch";
        update = "nix flake update";
        clean = "nh clean all";
        search = "nix search nixpkgs";

        # ── Docker ──────────────────────────────────────────
        d = "docker";
        dc = "docker compose";

        # ── Misc ────────────────────────────────────────────
        cls = "clear";
        ff = "fastfetch";
      };

      plugins = [
        {
          name = "fisher";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "fisher";
            rev = "4.4.5";
            sha256 = "sha256-VC8LMjwIvF6oG8ZVtFQvo2mGdyAzQyluAGBoK8N2/QM=";
          };
        }
      ];
    };

    # ── Source existing fish config files ──────────────────────
    xdg.configFile."fish/functions" = {
      source = ../../../config/fish/functions;
      recursive = true;
    };
    xdg.configFile."fish/conf.d" = {
      source = ../../../config/fish/conf.d;
      recursive = true;
    };
  };
}
