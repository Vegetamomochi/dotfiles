#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

rm -f ~/VirtualBoxVM-*.log >/dev/null 2>&1

# Ensure local binaries (our vi link) are recognized
export PATH="$HOME/.local/bin:$PATH"

# pywal - reload colors on terminal start
source ~/.cache/wal/colors.sh 2>/dev/null

# ueberzug++ 
export UEBERZUG_BACKEND=x11   # change to wayland if using wayland
export PATH="$PATH:$HOME/dotfiles/scripts/images-photos-wallpapers"
alias wallpaper='~/dotfiles/scripts/images-photos-wallpapers/fzfub ~/Wallpaper w'

# Define the file opener program/script for fff
export FFF_OPENER="$HOME/.local/bin/fff-opener"
