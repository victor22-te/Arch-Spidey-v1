#!/usr/bin/env bash
# ==============================================================================
# SPIDER-MAN 2099 // LYLA CYBER-HUD - ARCH LINUX + GNOME INSTALLER
# Restaura o instala toda la personalización en cualquier equipo con Arch + GNOME
# ==============================================================================
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_USER="$(whoami)"
TARGET_HOME="$HOME"

echo -e "\e[1;31m╔══════════════════════════════════════════════════════════════╗\e[0m"
echo -e "\e[1;31m║  🕷  INSTALADOR SPIDER-MAN 2099 // LYLA CYBER-HUD (ARCH OS)   ║\e[0m"
echo -e "\e[1;31m╚══════════════════════════════════════════════════════════════╝\e[0m"

# 1. Instalar paquetes base necesarios si estamos en Arch Linux y faltan
NEEDED_PKGS=()
for pkg in kitty fastfetch starship ttf-jetbrains-mono-nerd librsvg imagemagick python-gobject gtk4; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        NEEDED_PKGS+=("$pkg")
    fi
done

if [ "${#NEEDED_PKGS[@]}" -gt 0 ]; then
    echo -e "\e[1;36m[⚡] Instalando paquetes necesarios con pacman: ${NEEDED_PKGS[*]}...\e[0m"
    sudo pacman -S --needed --noconfirm "${NEEDED_PKGS[@]}" || true
fi

# 2. Crear directorios destino
echo -e "\e[1;36m[🕸] Creando estructura de directorios en $TARGET_HOME...\e[0m"
mkdir -p "$TARGET_HOME/.config"/{kitty,fastfetch,gtk-3.0,gtk-4.0,autostart}
mkdir -p "$TARGET_HOME/.local/bin"
mkdir -p "$TARGET_HOME/.local/share"/{applications,icons/hicolor/scalable/apps,gnome-shell/extensions,themes}
mkdir -p "$TARGET_HOME/.themes"
mkdir -p "$TARGET_HOME/Pictures" "$TARGET_HOME/Imágenes"

# 3. Copiar configuraciones de ~/.config
echo -e "\e[1;36m[🕸] Restaurando Kitty, Fastfetch, Starship y temas GTK3/GTK4...\e[0m"
cp -r "$REPO_DIR/config/kitty/"* "$TARGET_HOME/.config/kitty/"
cp -r "$REPO_DIR/config/fastfetch/"* "$TARGET_HOME/.config/fastfetch/"
cp "$REPO_DIR/config/starship.toml" "$TARGET_HOME/.config/starship.toml"
cp -r "$REPO_DIR/config/gtk-3.0/"* "$TARGET_HOME/.config/gtk-3.0/"
cp -r "$REPO_DIR/config/gtk-4.0/"* "$TARGET_HOME/.config/gtk-4.0/"
cp "$REPO_DIR/config/autostart/lyla-widget.desktop" "$TARGET_HOME/.config/autostart/"

# 4. Copiar archivos de Home (.bashrc y .face)
cp "$REPO_DIR/home/.bashrc" "$TARGET_HOME/.bashrc"
cp "$REPO_DIR/home/.face" "$TARGET_HOME/.face"
chmod 644 "$TARGET_HOME/.face"

# 5. Copiar scripts, iconos, lanzadores, extensión GNOME y tema completo
echo -e "\e[1;36m[🕸] Instalando scripts LYLA HUD, extensión GNOME y tema SpiderMan-2099-Cyber...\e[0m"
cp "$REPO_DIR/local/bin/spider-hud" "$TARGET_HOME/.local/bin/"
cp "$REPO_DIR/local/bin/lyla-widget" "$TARGET_HOME/.local/bin/"
chmod +x "$TARGET_HOME/.local/bin/spider-hud" "$TARGET_HOME/.local/bin/lyla-widget"

cp "$REPO_DIR/local/share/applications/"*.desktop "$TARGET_HOME/.local/share/applications/"
cp "$REPO_DIR/local/share/icons/hicolor/scalable/apps/spiderman-2099.svg" "$TARGET_HOME/.local/share/icons/hicolor/scalable/apps/"
cp -r "$REPO_DIR/local/share/gnome-shell/extensions/spider-hud@spiderman.2099" "$TARGET_HOME/.local/share/gnome-shell/extensions/"
cp -r "$REPO_DIR/local/share/themes/SpiderMan-2099-Cyber" "$TARGET_HOME/.local/share/themes/"
cp -r "$REPO_DIR/local/share/themes/SpiderMan-2099-Cyber" "$TARGET_HOME/.themes/"

# 6. Copiar Wallpapers y Avatar
echo -e "\e[1;36m[🕸] Copiando fondos de pantalla y avatar Spider-Man 2099...\e[0m"
cp "$REPO_DIR/wallpapers/"* "$TARGET_HOME/Pictures/"
cp "$REPO_DIR/wallpapers/spiderman_2099_cyber.jpg" "$TARGET_HOME/Pictures/spiderman_cyberpunk.jpg"
cp "$REPO_DIR/wallpapers/spiderman_2099_cyber.jpg" "$TARGET_HOME/Imágenes/spiderman_2099_cyber.jpg" 2>/dev/null || true

# 7. Adaptar rutas si el usuario en el nuevo dispositivo no se llama 'spider-man'
if [ "$TARGET_HOME" != "/home/spider-man" ]; then
    echo -e "\e[1;33m[⚡] Adaptando rutas de /home/spider-man a $TARGET_HOME...\e[0m"
    sed -i "s|/home/spider-man|$TARGET_HOME|g" \
        "$TARGET_HOME/.bashrc" \
        "$TARGET_HOME/.config/kitty/kitty.conf" \
        "$TARGET_HOME/.config/autostart/lyla-widget.desktop" \
        "$TARGET_HOME/.local/bin/lyla-widget" \
        "$TARGET_HOME/.local/share/applications/lyla-widget.desktop" \
        "$TARGET_HOME/.local/share/applications/spider-hud.desktop" \
        "$TARGET_HOME/.local/share/gnome-shell/extensions/spider-hud@spiderman.2099/extension.js"
fi

# 8. Aplicar configuraciones de GNOME (gsettings / dconf) y Avatar AccountsService
echo -e "\e[1;36m[🕸] Aplicando configuraciones de GNOME, fondos y atajos de teclado...\e[0m"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'SpiderMan-2099-Cyber'
gsettings set org.gnome.desktop.interface accent-color 'red' 2>/dev/null || true
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 11'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

gsettings set org.gnome.desktop.background picture-uri "file://$TARGET_HOME/Pictures/spiderman_2099_cyber.jpg"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$TARGET_HOME/Pictures/spiderman_2099_cyber.jpg"
gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.desktop.screensaver picture-uri "file://$TARGET_HOME/Pictures/spiderman_2099_cyber.jpg"
gsettings set org.gnome.desktop.screensaver picture-options 'zoom'

gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell enabled-extensions "['spider-hud@spiderman.2099']"
gsettings set org.gnome.shell favorite-apps "['kitty.desktop', 'lyla-widget.desktop', 'spider-hud.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.Settings.desktop']"

# Atajos de teclado
gsettings set org.gnome.shell.keybindings toggle-quick-settings "['<Super><Shift>s']"
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>Down']"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[]"

KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider0/ name 'Cyber-Terminal (Super+Enter)'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider0/ command '/usr/bin/kitty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider0/ binding '<Super>Return'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider1/ name 'LYLA Tactical Monitor (Super+S)'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider1/ command "/usr/bin/kitty --title \"LYLA // SPIDER-MAN 2099 TACTICAL HUD\" -e $TARGET_HOME/.local/bin/spider-hud"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider1/ binding '<Super>s'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider2/ name 'LYLA 2099 Widget (Super+H)'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider2/ command "$TARGET_HOME/.local/bin/lyla-widget"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider2/ binding '<Super>h'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider3/ name 'Cyber-Terminal (Ctrl+Alt+T)'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider3/ command '/usr/bin/kitty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider3/ binding '<Control><Alt>t'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider4/ name 'LYLA Tactical Monitor (Ctrl+Alt+S)'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider4/ command "/usr/bin/kitty --title \"LYLA // SPIDER-MAN 2099 TACTICAL HUD\" -e $TARGET_HOME/.local/bin/spider-hud"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_PATH}/spider4/ binding '<Control><Alt>s'

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['${KEY_PATH}/spider0/', '${KEY_PATH}/spider1/', '${KEY_PATH}/spider2/', '${KEY_PATH}/spider3/', '${KEY_PATH}/spider4/']"

# Avatar en AccountsService (Pantalla de bloqueo y login)
chmod o+x "$TARGET_HOME" "$TARGET_HOME/Pictures" 2>/dev/null || true
USER_OBJ=$(gdbus call --system --dest org.freedesktop.Accounts --object-path /org/freedesktop/Accounts --method org.freedesktop.Accounts.FindUserByName "$TARGET_USER" 2>/dev/null | sed -E "s/.*'([^']+)'.*/\1/")
if [ -n "$USER_OBJ" ]; then
    gdbus call --system --dest org.freedesktop.Accounts --object-path "$USER_OBJ" --method org.freedesktop.Accounts.User.SetIconFile "$TARGET_HOME/Pictures/spiderman_2099_avatar.png" >/dev/null 2>&1 || true
fi

echo -e "\e[1;32m[✔] ¡Instalación Spider-Man 2099 // LYLA Cyber-HUD completada con éxito!\e[0m"
echo -e "\e[1;36m    Cierra sesión y vuelve a entrar para que GNOME Shell cargue la extensión de barra superior y calendario.\e[0m"
