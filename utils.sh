#!/usr/bin/env bash

# Detect package manager
if command -v dnf &>/dev/null; then
  PKG_MANAGER="dnf"
elif command -v apt &>/dev/null; then
  PKG_MANAGER="apt"
else
  echo "Unsupported distro. Exiting."
  exit 1
fi

is_installed() {
  if [ "$PKG_MANAGER" = "dnf" ]; then
    dnf list installed "$1" &>/dev/null
  elif [ "$PKG_MANAGER" = "apt" ]; then
    dpkg -s "$1" &>/dev/null
  fi
}

install_packages() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing: ${to_install[*]}"
    if [ "$PKG_MANAGER" = "dnf" ]; then
      sudo dnf install -y "${to_install[@]}"
    elif [ "$PKG_MANAGER" = "apt" ]; then
      sudo apt update
      sudo apt install -y "${to_install[@]}"
    fi
  else
    echo "All packages already installed."
  fi
}

