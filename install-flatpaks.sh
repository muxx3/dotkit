#!/usr/bin/env bash
set -e

FLATPAKS=(
  "com.spotify.Client"
  "com.discordapp.Discord"
  "com.google.Chrome"
)

for pak in "${FLATPAKS[@]}"; do
  if ! flatpak list | grep -i "$pak" &> /dev/null; then
    echo "Installing Flatpak: $pak"
    flatpak install -y --noninteractive "$pak"
  else
    echo "Flatpak already installed: $pak"
  fi
done

