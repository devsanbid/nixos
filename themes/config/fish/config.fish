if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
# set _JAVA_AWT_WM_NONREPARENTING 1

set -x FZF_CTRL_T_OPTS "
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"
set GIT_LFS_SKIP_SMUDGE 1
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_DISABLE_KEYBINDINGS 0
set fish_cursor_default block
set fish_autosuggestion_enabled 0
zoxide init fish | source
export LS_COLORS="$(vivid generate $HOME/.config/vivid/colorscheme-lsd.yaml)"


fish_vi_key_bindings
set -g fish_key_bindings fish_vi_key_bindings
set -g fish_escape_delay_ms 100

bind -m default \x20eh 'nvim ~/dotfiles/.config/hypr/hyprland.conf'
bind -m default \x20ef 'nvim ~/dotfiles/.config/fish/config.fish'
bind -m default gp "cd ~/Desktop/project/pratice &> /dev/null"
bind -m default gw "cd ~/Desktop/project/working &> /dev/null"
bind -m default \x20\x20 'cd ~ && fzf | xargs nvim {} && clear'
bind -m default \x20r 'source ~/.config/fish/config.fish'
bind -m default \x20gs 'cd ~/.dotfiles && git add --all && git commit -a -m \"$(random)\"'
bind -m default \x20gp 'cd ~/.dotfiles && git push'


### usefully function ###
function cd
    builtin cd $argv; and ls
end

function cdx
    builtin cd $argv
end

set MANPAGER "nvim +Man!"






###### add to path #########
# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# bun
if test -d ~/.bun/bin
    if not contains -- ~/.bun/bin $PATH
        set -p PATH ~/.bun/bin
    end
end

# bun
if test -d ~/.cargo/bin
    if not contains -- ~/.cargo/bin $PATH
        set -p PATH ~/.cargo/bin
    end
end

if not test -x /usr/bin/yay; and test -x /usr/bin/paru
    alias yay 'paru --bottomup'
end

alias oo "sudo systemctl restart ollama"
alias fixit "pkill -f xwaylandvideobridge"

###### alias #########
alias ivm 'vim'
alias la 'eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ls 'eza --color=always --group-directories-first --icons'  # all files and dirs
alias ll 'eza -l --color=always --group-directories-first --icons'  # long format
alias lt 'eza -aT --color=always --group-directories-first --icons' # tree listing
alias l. 'eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles
alias cargo 'cargo -q'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias ip 'ip -color'
alias upd 'sudo pacman -Syu --noconfirm'
alias wget 'wget -c '
alias vim "nvim"
alias cls 'clear'
alias cl 'clear'
alias netbeans 'netbeans --fontsize 28'
alias avim 'NVIM_APPNAME=astro_nvim nvim'
set -gx CLASSPATH "/nix/store/b3kcs51w5fcp0maj62aln2h854zb64xv-mysql-connector-java-9.1.0/share/java/mysql-connector-j.jar:$CLASSPATH"
alias wf-recorder='wf-recorder --audio=alsa_input.pci-0000_00_1f.3.analog-stereo'

alias lvim "NVIM_APPNAME=lazy_nvim nvim"




# Replace some more things with better alternatives
alias cat 'bat -pp'

# Starship prompt
 if status --is-interactive
    source (starship init fish --print-full-init | psub)
 end

# syntax highlight
set -g fish_color_error red FF7276
set -g OLLAMA_API_BASE_URL http://127.0.0.1:11434
set -g OLLAMA_HOST 127.0.0.1:11434
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set --export ATAC_MAIN_DIR $HOME/.config/atac
set --export ATAC_KEY_BINDINGS $HOME/.config/atac/key_bindings_templates/vim_key_bindings.toml

set --export KITTY_ENABLE_WAYLAND 1

# >>> mamba initialize >>>
set -gx MAMBA_EXE "/nix/store/l2125zbsxc6xsj5rihsc780bqbfyfz96-micromamba-1.5.8/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/home/sanbid/micromamba"
# <<< mamba initialize <<<

set fish_path "/run/current-system/sw/bin/fish"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /home/sanbid/anaconda3/bin/conda
#     eval /home/sanbid/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# else
#     if test -f "/home/sanbid/anaconda3/etc/fish/conf.d/conda.fish"
#         . "/home/sanbid/anaconda3/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH "/home/sanbid/anaconda3/bin" $PATH
#     end
# end
# <<< conda initialize <<<


# source ~/.config/fish/private_variable.fish
