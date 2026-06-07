#!/bin/bash
echo "Initializing directory structures..."

# Create paths so the Xresources/Pywal patches don't choke on a blank install
mkdir -p ~/.cache/wal

# Generate safe fallback colors for dmenu/dwm to read on first launch
cat << 'EOF' > ~/.cache/wal/colors-wal.dwm
static const char *colors[SchemeLast][2] = {
        [SchemeNorm] = { "#bbbbbb", "#222222" },
        [SchemeSel]  = { "#eeeeee", "#005577" },
        [SchemeOut]  = { "#000000", "#00ffff" },
};
EOF

# Build standard fallback resource profiles
cat << 'EOF' > ~/.Xresources
*.background: #222222
*.foreground: #bbbbbb
*.color0: #222222
*.color1: #005577
*.color2: #00ffff
EOF

# Load defaults into the active X display server layout
xrdb -merge ~/.Xresources

echo "Beginning build sequence for suckless utilities..."

# Compile dmenu globally
cd ~/dotfiles/suckless/dmenu && sudo make clean install

# Compile dwm globally
cd ~/dotfiles/suckless/dwm && sudo make clean install

# Compile st globally
cd ~/dotfiles/suckless/st && sudo make clean install

# Compile dwmblocks globally
cd ~/dotfiles/suckless/dwmblocks && sudo make clean install

echo "Success! Your environment has been completely built and initialized."
