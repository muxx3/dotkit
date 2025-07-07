#!/usr/bin/env bash
set -e

if ! command -v tmux &>/dev/null; then
  echo "tmux is not installed."
  exit 1
fi

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ -d "$TPM_DIR" ]; then
  echo "TPM already installed in $TPM_DIR"
else
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

echo "TPM installed successfully!"
echo "Now opening tmux session and installing plugins..."

tmux new-session -d -s tpm_install_session

tmux send-keys -t tpm_install_session C-s "I" C-m

tmux attach -t tpm_install_session

exit 0

