source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# run zellij once everytime i open the terminal
#if [[ -z "$ZELLIJ" ]]; then
#    zellij
#fi

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# ??? ZVM_CURSOR_STYLE_ENABLED = false ???

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# alias cd="z"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
