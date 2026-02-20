# Tmux — prefix Ctrl+A, vi mode, plugins, clipboard
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.shell.tmux;
in
{
  options.modules.home.shell.tmux = {
    enable = lib.mkEnableOption "Tmux terminal multiplexer";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      terminal = "tmux-256color";
      prefix = "C-a";
      baseIndex = 1;
      mouse = true;
      keyMode = "vi";
      escapeTime = 10;
      historyLimit = 50000;

      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        resurrect
        continuum
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor 'mocha'
          '';
        }
        vim-tmux-navigator
        fzf-tmux-url
      ];

      extraConfig = ''
        # ── True color support ──────────────────────────────
        set -ag terminal-overrides ",xterm-256color:RGB"
        set -g default-terminal "tmux-256color"

        # ── Vi-style copy mode ──────────────────────────────
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"

        # ── Split panes (intuitive) ────────────────────────
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        unbind '"'
        unbind %

        # ── New window in current path ──────────────────────
        bind c new-window -c "#{pane_current_path}"

        # ── Resize panes with vim keys ──────────────────────
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5

        # ── Quick reload ────────────────────────────────────
        bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

        # ── Continuum auto-save ─────────────────────────────
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '15'
        set -g @resurrect-capture-pane-contents 'on'
      '';
    };
  };
}
