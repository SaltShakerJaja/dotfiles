#!/bin/bash

set -e

echo "[+] Cloning dotfiles..."
git clone https://github.com/SaltShakerJaja/dotfiles.git ~/dotfiles

echo "[+] Installing essential packages..."
sudo pacman -Syu --noconfirm git npm neovim zsh pipewire hyprland waybar ...

echo "[+] Installing yay ..."
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
fi

echo "[+] Symlinking config files..."
ln -sf ~/dotfiles/nvim ~/.config/nvim
# repeat for hyprland, waybar, etc.

echo "[+] Setting zsh as default shell..."
chsh -s /bin/zsh

echo "[+] Enabling services..."
sudo systemctl enable --now NetworkManager pipewire.service

echo "[✓] Setup complete!"

