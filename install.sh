#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# =====================================================================
# ENVIRONMENT SETUP & COLORS
# =====================================================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Determine the absolute path of the dotfiles directory dynamically
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"

echo -e "${BLUE}========================================= ${NC}"
echo -e "${BLUE}      STARTING DOTFILES INSTALLATION       ${NC}"
echo -e "${BLUE}========================================= ${NC}"

# ---------------------------------------------------------------------
# PHASE 1: PREREQUISITES & PACKAGE MANAGER INSTALLATION
# ---------------------------------------------------------------------

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "[-] Platform detected: macOS"

    if ! command -v brew &> /dev/null; then
        echo "[+] Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://githubusercontent.com)"

        # Add Homebrew to PATH for the current session (Intel/Apple Silicon)
        if [[ $(uname -m) == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        echo -e "${GREEN}[+] Homebrew is already installed.${NC}"
    fi

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "[-] Platform detected: Linux"

    # Identify Linux distribution to install basic compilation tools and zsh
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian|pop|mint)
                echo "[+] System base: Debian/Ubuntu. Installing essential dependencies..."
                sudo apt update
                sudo apt install -y build-essential procps curl file git zsh
                ;;
            arch|manjaro)
                echo "[+] System base: Arch Linux. Installing essential dependencies..."
                sudo pacman -Sy --needed --noconfirm base-devel procps-ng curl file git zsh
                ;;
            fedora)
                echo "[+] System base: Fedora / Fedora Asahi. Installing essential dependencies..."
                sudo dnf groupinstall -y "Development Tools" "Development Libraries"
                sudo dnf install -y procps-ng curl file git zsh
                ;;
            *)
                echo -e "${YELLOW}[!] Warning: Unknown Linux distro ($ID). Ensure curl, git, zsh, and compilers are installed.${NC}"
                ;;
        esac
    fi

    # Install Homebrew for Linux
    if ! command -v brew &> /dev/null; then
        echo "[+] Homebrew not found. Installing Linuxbrew..."
        /bin/bash -c "$(curl -fsSL https://githubusercontent.com)"
    else
        echo -e "${GREEN}[+] Homebrew is already installed.${NC}"
    fi

    # Dynamic path detection for Homebrew on Linux (Handles Asahi ARM64 /opt/homebrew vs Intel /home/linuxbrew)
    if [ -d "/opt/homebrew" ]; then
        LINUX_BREW_PREFIX="/opt/homebrew"
    else
        LINUX_BREW_PREFIX="/home/linuxbrew/.linuxbrew"
    fi

    # Add Homebrew to PATH for the current installation session
    eval "$($LINUX_BREW_PREFIX/bin/brew shellenv)"

    # Automatically configure shell environment for Linuxbrew
    echo "[+] Configuring shell environment for Homebrew..."
    BREW_ENV_CMD="eval \"\$($LINUX_BREW_PREFIX/bin/brew shellenv)\""

    # Check and update .zshrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
        if ! grep -q "brew shellenv" "$HOME/.zshrc"; then
            echo -e "\n# Homebrew initialization" >> "$HOME/.zshrc"
            echo "$BREW_ENV_CMD" >> "$HOME/.zshrc"
            echo "[+] Added Homebrew to $HOME/.zshrc"
        fi
    fi

    # Check and update .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        if ! grep -q "brew shellenv" "$HOME/.bashrc"; then
            echo -e "\n# Homebrew initialization" >> "$HOME/.bashrc"
            echo "$BREW_ENV_CMD" >> "$HOME/.bashrc"
            echo "[+] Added Homebrew to $HOME/.bashrc"
        fi
    fi
fi

# ---------------------------------------------------------------------
# PHASE 2: APPLICATION INSTALLATION VIA BREWFILE
# ---------------------------------------------------------------------

echo -e "\n${BLUE}-----------------------------------------${NC}"
echo -e "${BLUE} Installing Apps via Brewfile            ${NC}"
echo -e "${BLUE}-----------------------------------------${NC}"

if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo "[+] Brewfile located. Syncing packages..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
else
    echo -e "${YELLOW}[!] Warning: Brewfile not found in $DOTFILES_DIR. Skipping package installation.${NC}"
fi

# ---------------------------------------------------------------------
# PHASE 3: CONFIGURATION SYMLINKS
# ---------------------------------------------------------------------

echo -e "\n${BLUE}-----------------------------------------${NC}"
echo -e "${BLUE} Creating Symbolic Links                 ${NC}"
echo -e "${BLUE}-----------------------------------------${NC}"

# Helper function to safely create symlinks with backups
create_symlink() {
    local source=$1
    local target=$2

    # Ensure the parent directory for the target path exists
    mkdir -p "$(dirname "$target")"

    # Backup existing file/directory if it exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}[!] Backup created: $target -> ${target}.bak${NC}"
        mv "$target" "${target}.bak"
    fi

    # Create or overwrite the symbolic link
    ln -sf "$source" "$target"
    echo "[+] Linked: $(basename "$target") -> $target"
}

# Link map: create_symlink "SOURCE" "TARGET"
create_symlink "$DOTFILES_DIR/wezterm/.wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
create_symlink "$DOTFILES_DIR/vim/.vimrc"           "$HOME/.vimrc"
create_symlink "$DOTFILES_DIR/zsh/.zshrc"           "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/git/.gitconfig"       "$HOME/.gitconfig"

# ---- Create local secret files if they don't exist ----
echo -e "\n[+] Checking for local configuration files..."
if [ ! -f "$HOME/.gitconfig.local" ]; then
    echo -e "${YELLOW}[?] Setup Git User Identity (stays local on this machine):${NC}"
    
    # Interactive prompt for identity
    read -p "Enter your full name: " git_name
    read -p "Enter your git email: " git_email

    cat << EOF > "$HOME/.gitconfig.local"
[user]
    name = $git_name
    email = $git_email
EOF
    echo -e "${GREEN}[+] Created customized ~/.gitconfig.local${NC}"
fi

if [ ! -f "$HOME/.zshrc.local" ]; then
    cat << 'EOF' > "$HOME/.zshrc.local"
# Put your environment variables and private API keys here
# export GITHUB_TOKEN="your_token"
# export OPENAI_API_KEY="your_key"
EOF
    echo -e "${GREEN}[+] Created blank ~/.zshrc.local${NC}"
fi

# ---------------------------------------------------------------------
# PHASE 4: CHANGING DEFAULT SHELL TO ZSH
# ---------------------------------------------------------------------

echo -e "\n${BLUE}-----------------------------------------${NC}"
echo -e "${BLUE} Configuring Default Shell               ${NC}"
echo -e "${BLUE}-----------------------------------------${NC}"

if [[ "$SHELL" != *"zsh"* ]]; then
    if command -v zsh &> /dev/null; then
        ZSH_PATH=$(command -v zsh)
        echo "[+] Found Zsh at: $ZSH_PATH"

        # Ensure Zsh is added to /etc/shells (required by chsh on some systems)
        if ! grep -Fxq "$ZSH_PATH" /etc/shells; then
            echo "[+] Adding $ZSH_PATH to /etc/shells..."
            echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
        fi

        # Attempt to change the shell
        echo "[+] Changing your default shell to Zsh (password may be required)..."
        if chsh -s "$ZSH_PATH"; then
            echo -e "${GREEN}[+] Default shell successfully changed to Zsh.${NC}"
            echo -e "${YELLOW}[!] Please log out and log back in for the changes to take effect.${NC}"
        else
            echo -e "${YELLOW}[!] Warning: Failed to change shell via chsh. You may need to run 'chsh -s $ZSH_PATH' manually.${NC}"
        fi
    else
        echo -e "${YELLOW}[!] Warning: Zsh is not installed. Skipping shell change.${NC}"
    fi
else
    echo -e "${GREEN}[+] Zsh is already your default shell.${NC}"
fi

# ---------------------------------------------------------------------
# FINAL STATUS
# ---------------------------------------------------------------------

echo -e "\n${GREEN}========================================= ${NC}"
echo -e "${GREEN}  ALL APPS AND SYMLINKS DEPLOYED!         ${NC}"
echo -e "${GREEN}========================================= ${NC}"

