export ZSH_DISABLE_COMPFIX="true"
export TERM=xterm-256color

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    colored-man-pages
    vi-mode
)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ls='eza --icons=always'
alias tree='eza -T --icons=always'
alias cat=bat
alias fmtpandoc='pandoc --pdf-engine=lualatex -V geometry:"top=1.25in,bottom=1.25in,left=1in,right=1in" -V mainfont="STIX Two Text"'

if [[ $- == *i* ]]; then
    function nv() {
        local files
        # Get selected files from fzf
        files=($(fzf --multi --select-1 --exit-0 --preview="bat --color=always --style=numbers {}"))
        # Open in nvim if any selected
        if ((${#files[@]})); then
            nvim "${files[@]}"
        fi
    }
fi

n() {
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    nnn "$@"
    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" >/dev/null
    fi
}

bindkey -M vicmd 'v' visual-mode

export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
export EZA_ICON_SPACING=2
BLK="03" CHR="03" DIR="04" EXE="02" REG="07" HARDLINK="05" SYMLINK="05" MISSING="08" ORPHAN="01" FIFO="06" SOCK="03" UNKNOWN="01"
export NNN_COLORS="#04020301;4231"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PLUG='v:imgview;p:preview-tui'
export BAT_THEME=zenburn
export NNN_PREVIEWIMGPROG='chafa'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
source "$HOME/.atuin/bin/env"
source <(fzf --zsh)
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.4.1
