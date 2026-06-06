<p>
  <img src="misc/screenshots/fastfetch.png" width="49%">
  <img src="misc/screenshots/desktop.png" width="49%">
</p>

# DOTFILES

My personal Arch Linux + dwm desktop configuration. Minimal, keyboard-driven, and color-adaptive via pywal.

---

## System Overview

| Component | Tool |
|-----------|------|
| OS | Arch Linux |
| WM | dwm (suckless) |
| Terminal | st (suckless) |
| Launcher | dmenu |
| Shell | bash / zsh |
| File Manager | fff + ranger |
| Image Preview | ueberzug++ |
| Color Theming | pywal |
| Compositor | picom |
| Notifications | dunst |
| Status Bar | dwm built-in |

---

## Features

- **pywal** — generates a colorscheme from your wallpaper and propagates it to dwm, dmenu, st, dunst, and the terminal automatically on startup via `~/.bashrc`
- **ueberzug++** — image previews in the terminal (configured for X11 backend; switch to `wayland` in `bashrc` if needed)
- **fff** — fast, minimal terminal file manager with a custom opener script (`~/.local/bin/fff-opener`) for filetype handling
- **fzf + ueberzug++ wallpaper picker** — fuzzy wallpaper selection with live image preview via the `wallpaper` alias
- **suckless stack** — dwm, dmenu, and st are compiled from source with custom patches; edit `config.h` and run `install.sh` to rebuild

---

## Repository Structure

```
dotfiles/
├── config/          # App configs (ranger, dunst, picom, etc.)
├── misc/            # Miscellaneous extras
├── scripts/
│   └── images-photos-wallpapers/   # fzf+ueberzug++ wallpaper picker (fzfub)
├── suckless/
│   ├── dwm/         # Window manager source + config.h
│   ├── dmenu/       # Launcher source + config.h
│   └── st/          # Terminal source + config.h
├── .xinitrc         # X session startup
├── bashrc           # Shell config (pywal, ueberzug++, fff, PATH)
├── install.sh       # Bootstrap: build suckless tools, init pywal cache
├── pkglist-official.txt   # Official repo packages
└── pkglist-aur.txt        # AUR packages
```

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/Vegetamomochi/dotfiles ~/dotfiles
cd ~/dotfiles
```

### 2. Install packages

```bash
# Official packages
sudo pacman -S --needed - < pkglist-official.txt

# AUR packages (requires paru or yay)
paru -S --needed - < pkglist-aur.txt
```

### 3. Run the install script

Initializes the pywal cache (so dwm/dmenu don't choke on a blank install) and compiles the suckless tools:

```bash
chmod +x install.sh
./install.sh
```

### 4. Link configs

Copy or symlink the contents of `config/` to `~/.config/` as needed, and place `bashrc` at `~/.bashrc`:

```bash
cp bashrc ~/.bashrc
# Example for a single app:
ln -s ~/dotfiles/config/dunst ~/.config/dunst
```

### 5. Start the session

```bash
# Log in via TTY and startx, or configure your display manager to launch dwm
startx
```

---

## Theming with pywal

Pywal reads your wallpaper and generates a 16-color palette, then writes color files that dwm, dmenu, st, and dunst pick up automatically.

```bash
# Set a new wallpaper and regenerate colors
wal -i ~/Wallpaper/your-image.jpg

# Or use the fuzzy wallpaper picker (fzf + ueberzug++ preview)
wallpaper
```

Colors are sourced into the shell on every terminal start via `~/.bashrc`:

```bash
source ~/.cache/wal/colors.sh
```

---

## fff Configuration

fff uses a custom opener defined in `bashrc`:

```bash
export FFF_OPENER="$HOME/.local/bin/fff-opener"
```

Edit `~/.local/bin/fff-opener` to control how different file types are opened (images → imv/feh, video → mpv, PDFs → zathura, etc.).

### ueberzug++ image previews in fff

The X11 backend is set in `bashrc`:

```bash
export UEBERZUG_BACKEND=x11
```

Change to `wayland` if running a Wayland compositor.

---

## Suckless Tools

dwm, dmenu, and st are patched and configured via their respective `config.h` files. To apply changes:

```bash
cd ~/dotfiles/suckless/dwm
# Edit config.h
sudo make clean install

# Same for dmenu and st
```

The pywal dwm patch reads colors from `~/.cache/wal/colors-wal.dwm` — regenerated automatically when you run `wal`.

---

## AUR Packages

| Package | Purpose |
|---------|---------|
| `ani-cli` | Stream anime from the terminal |
| `ranger_devicons-git` | File icons in ranger |
| `sc-im` | Spreadsheet in the terminal |
| `micromamba-bin` | Lightweight conda environment manager |
| `mirage` | Fast image viewer |

---

## License

Personal dotfiles — feel free to take anything useful.

---

## Inspiration

Heavily inspired by **Bread** (BreadOnPenguins) — check out her work:

- GitHub: [github.com/BreadOnPenguins](https://github.com/BreadOnPenguins)
- YouTube: [youtube.com/@BreadOnPenguins](https://www.youtube.com/@BreadOnPenguins)
