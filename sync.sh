#!/bin/bash
set -e
DOTDIR="$HOME/dotfiles"

echo "==> Syncing suckless builds..."
cp -r ~/suckless/dwm/                "$DOTDIR/dwm/"
cp -r ~/suckless/dwmblocks/          "$DOTDIR/dwmblocks/"
cp -r ~/suckless/st/                 "$DOTDIR/st/"
cp -r ~/suckless/dmenu/              "$DOTDIR/dmenu/"

echo "==> Syncing scripts..."
cp -r ~/scripts/                     "$DOTDIR/scripts/"

echo "==> Syncing configs..."
cp -r ~/.config/picom/               "$DOTDIR/config/picom/"
cp -r ~/.config/dunst/               "$DOTDIR/config/dunst/"
cp -r ~/.config/nvim/                "$DOTDIR/config/nvim/"

echo "==> Syncing dotfiles..."
cp ~/.bashrc                         "$DOTDIR/.bashrc"
cp ~/.xinitrc                        "$DOTDIR/.xinitrc"
cp ~/.Xresources                     "$DOTDIR/.Xresources"
cp ~/.xbindkeysrc                    "$DOTDIR/.xbindkeysrc"

echo "==> Pushing to GitHub..."
cd "$DOTDIR"
git add .
git commit -m "Update $(date '+%Y-%m-%d %H:%M')"
git push -u origin main

echo "Done!"
