#!/bin/bash

set -e

echo "[+] Installing essential packages..."
sudo pacman -Syu --noconfirm git npm neovim zsh pipewire hyprland waybar

echo "[+] Installing yay..."
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
fi

apps=(
    kitty
    wofi
    grim
    slurp
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    noto-fonts
    noto-fonts-emoji
    ttf-jetbrains-mono
    bluez
    bluez-utils
    blueman
    networkmanager
    )

for pkg in "${apps[@]}"; do 
    if ! pacman -Qi "$pkg" &>dev/null; then
        echo " - Installing $pkg..."
        sudo pacman -S --noconfirm --needed "$pkg"
    else
        echo " - Package already installed"
    fi
done

echo "[+] Symlinking config files..."
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/.config/hypr ~/.config/hypr
ln -sf ~/.dotfiles/.config/waybar ~/.config/waybar
# repeat for hyprland, waybar, etc.

echo "[+] Enabling services..."
SERVICES=(bluetooth NetworkManager)
for svc in "${SERVICES[@]}"; do 
    sudo systemctl enable "$svc.service"
    sudo systemctl start "$svc.service"
done

echo "[+] Setting zsh as default shell..."
chsh -s /bin/zsh

echo "[✓] Setup complete!"

