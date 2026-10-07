#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Start install dotfiles ===${NC}"

echo "Creating directories..."
mkdir -p "$HOME/.config/wezterm"

echo "Creating symbolic links..."
ln -sf "$HOME/.dotfiles/wezterm/.wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
ln -sf "$HOME/.dotfiles/vim/.vimrc"           "$HOME/.vimrc"
ln -sf "$HOME/.dotfiles/zsh/.zshrc"           "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/git/.gitconfig"       "$HOME/.gitconfig"

echo -e "${GREEN}=== All symlinks successfully created! ===${NC}"
