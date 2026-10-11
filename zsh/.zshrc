# ---- Environment Variables & Paths ----
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# ---- History Setup ----
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# ---- Key Bindings ----
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Tool Initializations ----
eval "$(zoxide init zsh)"

# ---- Local Configs & Secrets ----
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# ---- Advanced Tab Completion Setup ----
# Enable the built-in Zsh completion system
autoload -U compinit && compinit

# Enable interactive completion menu (allows navigation via arrow keys)
zstyle ':completion:*' menu select

# ---- Zsh Plugins (MUST BE AT THE VERY END) ----
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

