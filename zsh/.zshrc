# ---- Environment Variables & Paths ----
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# ---- History Setup ----
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# ---- Key Bindings ----
# Completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Tool Initializations ----
# Run zellij once everytime i open the terminal
#if [[ -z "$ZELLIJ" ]]; then
#    zellij
#fi

# Zoxide (better cd)
eval "$(zoxide init zsh)"
# alias cd="z"

# ---- Zsh Plugins (MUST BE AT THE VERY END) ----
# Load completions first, then syntax highlighting
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
