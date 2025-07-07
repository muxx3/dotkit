#!/usr/bin/env bash
set -e

# Print logo
print_logo() {
    cat << "EOF"
;
 ______   _______  _______  ___   _  ___   _______
|      | |       ||       ||   | | ||   | |       |
|  _    ||   _   ||_     _||   |_| ||   | |_     _|
| | |   ||  | |  |  |   |  |      _||   |   |   |
| |_|   ||  |_|  |  |   |  |     |_ |   |   |   |
|       ||       |  |   |  |    _  ||   |   |   |   Fedora & Ubuntu System Kit Builder
|______| |_______|  |___|  |___| |_||___|   |___|   by: muxxe_
EOF
}

# Parse flags
DEV_ONLY=false
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --dev-only) DEV_ONLY=true; shift ;;
    *) echo "Unknown parameter: $1"; exit 1 ;;
  esac
done

clear
print_logo

source ./utils.sh

if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source ./packages.conf

if [[ "$DEV_ONLY" == true ]]; then
  echo "Starting development-only setup..."
else
  echo "Starting full system setup..."
fi

# Update system
echo "Updating system..."
if [ "$PKG_MANAGER" = "dnf" ]; then
  sudo dnf upgrade --refresh -y
elif [ "$PKG_MANAGER" = "apt" ]; then
  sudo apt update && sudo apt upgrade -y
fi

if [[ "$DEV_ONLY" == true ]]; then
  echo "Installing CORE packages..."
  install_packages "${CORE[@]}"

  echo "Installing DEV packages..."
  install_packages "${DEV[@]}"
else
  echo "Installing CORE packages..."
  install_packages "${CORE[@]}"

  echo "Installing WM packages..."
  install_packages "${WM[@]}"

  echo "Installing FONTS packages..."
  install_packages "${FONTS[@]}"

  echo "Installing APPS packages..."
  install_packages "${APPS[@]}"

  echo "Installing DEV packages..."
  install_packages "${DEV[@]}"

  echo "Installing AUDIO packages..."
  install_packages "${AUDIO[@]}"

  # Enable services
  echo "Enabling services..."
  for service in "${SERVICES[@]}"; do
    sudo systemctl enable "$service"
  done

  # Install dotfiles
  bash install-dotfiles.sh

  # Install TPM
  bash install-tpm.sh

  # Install flatpaks
  bash install-flatpaks.sh
fi

echo "✅ Setup complete! Reboot recommended."

