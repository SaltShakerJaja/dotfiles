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
    wget
    curl
    unzip
    rsync
    flatpak
    git
    lua-language-server
    gopls
    power-profiles-daemon
    wl-clipboard
    nerd-fonts
    fastfetch
    gtk3
    gtk4
    gtk-layer-shell
    nwg-drawer
    nwg-displays
    gnome-themes-extra
    adwaita-icon-theme
    lxappearance
    qt6ct
    qt6-base
    qt6-svg
    xsettingsd
    imagemagick
    jq
    fzf
    python-pywal
    python-imageio
    python-gobject
    ripgrep
    hyprpaper
    rofi-wayland
    nwg-look
    pavucontrol
    htop
    slurp
    kitty
    wofi
    grim
    cliphist
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xdg-user-dirs
    brightnessctl
    gvfs
    ttf-roboto
    ttf-fira-sans
    ttf-font-awesome
    otf-font-awesome
    noto-fonts
    noto-fonts-emoji
    ttf-jetbrains-mono
    bluez
    bluez-utils
    blueman
    networkmanager
    hyprpaper
    hyprlock
    hypridle
    hyprpicker
    vlc
    )

for pkg in "${apps[@]}"; do 
    if ! pacman -Qi "$pkg" &>dev/null; then
        echo " - Installing $pkg..."
        sudo pacman -S --noconfirm --needed "$pkg"
    else
        echo " - Package already installed"
    fi
done

aur_packages=(
    wlogout
    swaync
    nwg-dock-hyprland
    wallust
    matugen
    waypaper
    eza
    oh-my-posh
    )

for pkg in "${aur_packages[@]}"; do 
    echo " - Installing $pkg..."
    yay -S --noconfirm --needed "$pkg"
done

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no KEEP_ZSH=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

[ -d $HOME/.local/bin ] || mkdir -p $HOME/.local/bin
cp /usr/bin/wallust $HOME/.local/bin/
cp /usr/bin/matugen $HOME/.local/bin/

install_zsh_plugin() {
    local repo_url="$1"
    local plugin_name="$2"
    local plugin_path="$ZSH_CUSTOM/plugins/$plugin_name"

    if [ ! -d "$plugin_path" ]; then
        echo "Installing $plugin_name..."
        git clone "$repo_url" "$plugin_path"
    else
        echo "$plugin_name already installed at $plugin_path"
    fi
}

install_zsh_plugin https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions
install_zsh_plugin https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting


echo "[+] Symlinking config files..."
for dir in "$HOME/.dotfiles/.config/"*; do 
    name=$(basename "$dir")
    target="$HOME/.config/$name"

    [ -e "$target" ] && rm -rf "$target"
    ln -sf "$dir" "$target"
    echo " - Linked $name"
done

cp -f "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
cp -f "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"

echo "[+] Enabling services..."
SERVICES=(bluetooth NetworkManager)
for svc in "${SERVICES[@]}"; do 
    sudo systemctl enable "$svc.service"
    sudo systemctl start "$svc.service"
done

find ~/.config/juan/settings -type f -name "*.sh" -exec chmod +x {} +
sudo usermod -aG wheel,audio,video,input,network,lp,power,kvm juan 

echo "[+] Setting zsh as default shell..."
chsh -s /bin/zsh

echo "[✓] Setup complete!"

