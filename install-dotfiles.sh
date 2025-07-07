#!/usr/bin/env bash
set -e

source ./utils.sh

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="git@github.com:muxx3/dotfiles.git"

if ! is_installed "stow"; then
  echo "Stow not installed. Installing..."
  install_packages stow
fi

cd ~

if [ -d "$DOTFILES_DIR" ]; then
  echo "Dotfiles repo already exists. Pulling latest..."
  cd "$DOTFILES_DIR"
  git pull
else
  echo "Cloning dotfiles..."
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

DOTFILES_TO_STOW=(
  btop
  fastfetch
  fish
  i3
  kitty
  lazygit
  neovim
  picom
  polybar
  ranger
  tmux
)

for dir in "${DOTFILES_TO_STOW[@]}"; do
  if [ -d "$dir" ]; then
    echo "Stowing $dir..."
    stow "$dir"
  else
    echo "Warning: $dir missing in dotfiles repo."
  fi
done

echo "Dotfiles stowed successfully."

