# 🛠️ .dotfiles

My personal, secure, and cross-platform configuration files for **macOS** and **Linux**. This repository automates the setup of my development environment using a unified ecosystem built around **Zsh**, **WezTerm**, **Vim**, and **Homebrew**.

## 🚀 Quick Start

> [!WARNING]
> Before running the script, ensure you have internet access. The installation will automatically trigger Homebrew setup and request your Git identity for local machine configuration.

To deploy these dotfiles on a fresh machine, open your terminal and run:

```bash
# Clone the repository
git clone https://github.com ~/.dotfiles

# Navigate to the directory
cd ~/.dotfiles

# Make the installer executable and run it
chmod +x install.sh
./install.sh
```

## 📦 What's Inside?

The automated `install.sh` script handles deployment in 4 distinct phases:

### 1. Core Architecture & Package Managers
* **macOS & Linux Support:** Dynamically detects OS and CPU architecture (handles Apple Silicon `/opt/homebrew` vs Intel/Linux paths).
* **System Dependencies:** Automatically installs standard compilation tools via system package managers (`apt`, `pacman`, or `dnf`) before bootstrap.
* **Homebrew / Linuxbrew:** Automated zero-interaction installation.

### 2. Application Bundle (`Brewfile`)
Uses Homebrew Bundle to provision command-line utilities and applications natively. Key tools included:
* `zoxide` — A smarter `cd` command for rapid navigation.

### 3. Managed Configuration Symlinks
Safe symlinking helper that automatically creates `.bak` copies of your old configs if they already exist:
* `WezTerm` 🖥️ — `~/.config/wezterm/wezterm.lua`
* `Vim` 📝 — `~/.vimrc`
* `Zsh` 🐚 — `~/.zshrc`
* `Git` 🔧 — `~/.gitconfig`

### 4. Default Shell Transition
* Seamlessly registers and switches your system default shell environment to **Zsh**.

---

## 🔒 Security & Privacy Architecture

This repository is designed to be completely **publicly safe** while retaining fully personalized environments locally.

* **Split-Config Blueprint:** Critical settings are completely separated into non-tracked local variables (`~/.gitconfig.local` and `~/.zshrc.local`).
* **Interactive Setup:** On a fresh execution, `install.sh` prompts you for your local Git Name/Email in real-time, preventing metadata or private email harvesting on GitHub.
* **Hardened Leak Protection:** The repository includes a strict `.gitignore` layer blocking system trash (`.DS_Store`), compiler swaps (`.swp`), SSH components, shell history trackers (`.*_history`), and environmental secrets (`.env*`).

