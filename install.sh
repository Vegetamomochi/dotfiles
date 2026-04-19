#!/bin/bash
set -e

DOTDIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing packages..."
sudo pacman -S --needed --noconfirm \
    xorg xorg-xinit xorg-xsetroot \
    base-devel git \
    picom dunst \
    noto-fonts ttf-jetbrains-mono-nerd \
    neovim \
    feh maim \
    pulseaudio pulsemixer \
    brightnessctl \
    xbindkeys

echo "==> Building dwm..."
cd "$DOTDIR/dwm" && sudo make clean install

echo "==> Building dwmblocks..."
cd "$DOTDIR/dwmblocks" && sudo make clean install

echo "==> Building st..."
cd "$DOTDIR/st" && sudo make clean install

echo "==> Building dmenu..."
cd "$DOTDIR/dmenu" && sudo make clean install

echo "==> Copying configs..."
mkdir -p ~/.config/picom
mkdir -p ~/.config/dunst
mkdir -p ~/.config/nvim

cp -r "$DOTDIR/config/picom/"  ~/.config/picom/
cp -r "$DOTDIR/config/dunst/"  ~/.config/dunst/
cp -r "$DOTDIR/config/nvim/"   ~/.config/nvim/

echo "==> Copying dotfiles..."
cp "$DOTDIR/.xinitrc"     ~/
cp "$DOTDIR/.Xresources"  ~/
cp "$DOTDIR/.xbindkeysrc" ~/

echo "==> Copying scripts..."
mkdir -p ~/scripts
cp -r "$DOTDIR/scripts/"* ~/scripts/
chmod +x ~/scripts/*

echo "==> Merging .bashrc..."
cat "$DOTDIR/.bashrc" >> ~/.bashrc

echo ""
echo "Done! Run 'startx' to launch your rice."
