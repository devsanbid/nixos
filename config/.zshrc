if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export PATH="/home/sanbid/.cache/.bun/bin:$PATH"


ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-syntax-highlighting
  fzf
  z
  docker
  docker-compose
  jsontools


  ## without this i can't live ##
  tmux
  zsh-vi-mode
)

## tmux ##
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_FIXTERM=true

source $ZSH/oh-my-zsh.sh

## vim mode ##
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLOCK

export LS_COLORS="$(vivid generate $HOME/.config/vivid/colorscheme-lsd.yaml)"


function chpwd() {
  eza --color=always --group-directories-first --icons
}


export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

autoload -U compinit

alias ivm="vim"
alias la="eza -a --color=always --group-directories-first --icons"
alias ls="eza --color=always --group-directories-first --icons"
alias ll="eza -l --color=always --group-directories-first --icons"
alias lt="eza -aT --color=always --group-directories-first --icons"
alias cargo="cargo -q"
alias ip="ip -color"
alias upd="sudo pacman -Syu --noconfirm"
alias wget="wget -c "
alias vim="nvim"
alias cls="clear"
alias cl="clear"
alias netbeans="netbeans --fontsize 28"
alias CLASSPATH="/nix/store/b3kcs51w5fcp0maj62aln2h854zb64xv-mysql-connector-java-9.1.0/share/java/mysql-connector-j.jar:$CLASSPATH"
alias wf-recorder="wf-recorder --audio=alsa_input.pci-0000_00_1f.3.analog-stereo"
alias pgcli="pgcli -h localhost -p 5432 -U postgres -d postgres"



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
