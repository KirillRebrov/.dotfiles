#!/bin/bash

# ANSI color codes for pretty terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Start install dotfiles ===${NC}"

# 1. Check for Homebrew and install it if missing (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://githubusercontent.com)"
        
        # Add Homebrew to PATH for the current installation session
        # (Handles both Apple Silicon M1/M2/M3 and Intel Macs)
        if [[ $(uname -m) == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        echo -e "${GREEN}Homebrew is already installed.${NC}"
    fi
fi

# 2. Install applications from Brewfile
if [ -f "$HOME/.dotfiles/Brewfile" ]; then
    echo "Installing applications from Brewfile..."
    brew bundle --file="$HOME/.dotfiles/Brewfile"
else
    echo -e "${YELLOW}Warning: Brewfile not found. Skipping apps installation.${NC}"
fi

# Ensure configuration directories exist
echo "Creating directories..."
mkdir -p "$HOME/.config/wezterm"

# Helper function to safely create symlinks with backups
create_symlink() {
    local source=$1
    local target=$2

    # If the file exists and is NOT a symlink already, back it up
    if [ -f "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}Backup created for $target -> ${target}.bak${NC}"
        mv "$target" "${target}.bak"
    fi

    # Create or update the symbolic link
    ln -sf "$source" "$target"
}

echo "Creating symbolic links..."
# Link structure: create_symlink "SOURCE_IN_DOTFILES" "TARGET_IN_HOME"
create_symlink "$HOME/.dotfiles/wezterm/.wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
create_symlink "$HOME/.dotfiles/vim/.vimrc"           "$HOME/.vimrc"
create_symlink "$HOME/.dotfiles/zsh/.zshrc"           "$HOME/.zshrc"
create_symlink "$HOME/.dotfiles/git/.gitconfig"       "$HOME/.gitconfig"

echo -e "${GREEN}=== All apps and symlinks successfully installed! ===${NC}"
