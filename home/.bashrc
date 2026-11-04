# ==============================================================================
# .bashrc - SPIDER-MAN 2099 // LYLA CYBER-HUD EDITION (ARCH LINUX)
# ==============================================================================

# Si no estamos en shell interactivo, no hacer nada
[[ $- != *i* ]] && return

# Historial
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s checkwinsize

# Aliases de Pacman y Yay (Arch Linux)
alias pacup='sudo pacman -Syu'
alias yaup='yay -Syu'
alias pacin='sudo pacman -S'
alias yain='yay -S'
alias pacrm='sudo pacman -Rns'
alias pacsearch='pacman -Ss'
alias yasearch='yay -Ss'

# Aliases generales
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

# Aliases Tácticos Spider-Man 2099 // LYLA HUD
alias lyla='/home/spider-man/.local/bin/spider-hud'
alias hud='/home/spider-man/.local/bin/spider-hud'
alias spider-sense='/home/spider-man/.local/bin/spider-hud'
alias lyla-deck='nohup /home/spider-man/.local/bin/lyla-widget >/dev/null 2>&1 &'
alias spider-wall1='gsettings set org.gnome.desktop.background picture-uri "file:///home/spider-man/Pictures/spiderman_2099_cyber.jpg" && gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/spider-man/Pictures/spiderman_2099_cyber.jpg"'
alias spider-wall2='gsettings set org.gnome.desktop.background picture-uri "file:///home/spider-man/Pictures/spiderman_2099_hud_blueprint.png" && gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/spider-man/Pictures/spiderman_2099_hud_blueprint.png"'

# Antigravity CLI & Local binaries
export PATH="/home/spider-man/.local/bin:$PATH"

# Prompt Starship & Fastfetch
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

if [[ $- == *i* ]] && command -v fastfetch &> /dev/null; then
    fastfetch
fi

# Respaldo y Restauración de Dotfiles (GitHub)
alias spider-backup='/home/spider-man/Proyectos/spiderman-2099-dotfiles/backup.sh'
alias spider-restore='/home/spider-man/Proyectos/spiderman-2099-dotfiles/install.sh'
