#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="$HOME/scripts:$HOME/scripts/images-photos-wallpapers:$HOME/scripts/audio-video:$HOME/scripts/shell:$HOME/scripts/shortcuts-menus:$PATH"

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
