#!/usr/bin/env bash
# ==============================================================================
# SPIDER-MAN 2099 // LYLA CYBER-HUD - SCRIPT DE RESPALDO (BACKUP)
# Sincroniza los cambios actuales de tu sistema hacia el repositorio Git
# ==============================================================================
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "\e[1;36m[󰯊] Guardando configuraciones actuales en $REPO_DIR...\e[0m"

cp -r ~/.config/kitty/* "$REPO_DIR/config/kitty/"
cp -r ~/.config/fastfetch/* "$REPO_DIR/config/fastfetch/"
cp ~/.config/starship.toml "$REPO_DIR/config/starship.toml"
cp -r ~/.config/gtk-3.0/* "$REPO_DIR/config/gtk-3.0/"
cp -r ~/.config/gtk-4.0/* "$REPO_DIR/config/gtk-4.0/"
cp ~/.config/autostart/lyla-widget.desktop "$REPO_DIR/config/autostart/"
mkdir -p "$REPO_DIR/config/burn-my-windows"
cp -r ~/.config/burn-my-windows/* "$REPO_DIR/config/burn-my-windows/" 2>/dev/null || true

cp ~/.bashrc "$REPO_DIR/home/.bashrc"
cp ~/.face "$REPO_DIR/home/.face"

cp ~/.local/bin/spider-hud "$REPO_DIR/local/bin/"
cp ~/.local/bin/lyla-widget "$REPO_DIR/local/bin/"
cp ~/.local/bin/mic-volume "$REPO_DIR/local/bin/" 2>/dev/null || true
cp ~/.local/share/applications/lyla-widget.desktop "$REPO_DIR/local/share/applications/"
cp ~/.local/share/applications/spider-hud.desktop "$REPO_DIR/local/share/applications/"
cp ~/.local/share/icons/hicolor/scalable/apps/spiderman-2099.svg "$REPO_DIR/local/share/icons/hicolor/scalable/apps/"
cp -r ~/.local/share/gnome-shell/extensions/* "$REPO_DIR/local/share/gnome-shell/extensions/"
mkdir -p "$REPO_DIR/local/share/glib-2.0/schemas"
cp -r ~/.local/share/glib-2.0/schemas/* "$REPO_DIR/local/share/glib-2.0/schemas/" 2>/dev/null || true
cp -r ~/.local/share/themes/SpiderMan-2099-Cyber "$REPO_DIR/local/share/themes/"

cp ~/Pictures/spiderman_2099_cyber.jpg "$REPO_DIR/wallpapers/" 2>/dev/null || true
cp ~/Pictures/spiderman_2099_hud_blueprint.png "$REPO_DIR/wallpapers/" 2>/dev/null || true
cp ~/Pictures/spiderman_2099_avatar.png "$REPO_DIR/wallpapers/" 2>/dev/null || true
cp ~/Pictures/spiderman_2099_live.mp4 "$REPO_DIR/wallpapers/" 2>/dev/null || true
cp ~/Pictures/nissan_live.mp4 "$REPO_DIR/wallpapers/" 2>/dev/null || true

dconf dump /org/gnome/desktop/interface/ > "$REPO_DIR/gnome/interface.dconf"
dconf dump /org/gnome/desktop/background/ > "$REPO_DIR/gnome/background.dconf"
dconf dump /org/gnome/desktop/screensaver/ > "$REPO_DIR/gnome/screensaver.dconf"
dconf dump /org/gnome/desktop/wm/preferences/ > "$REPO_DIR/gnome/wm-preferences.dconf"
dconf dump /org/gnome/desktop/wm/keybindings/ > "$REPO_DIR/gnome/wm-keybindings.dconf"
dconf dump /org/gnome/shell/ > "$REPO_DIR/gnome/shell.dconf"
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > "$REPO_DIR/gnome/media-keys.dconf"
dconf dump /org/gnome/shell/extensions/dash-to-dock/ > "$REPO_DIR/gnome/dash-to-dock.dconf" 2>/dev/null || true
dconf dump /org/gnome/shell/extensions/burn-my-windows/ > "$REPO_DIR/gnome/burn-my-windows.dconf" 2>/dev/null || true
dconf dump /org/gnome/shell/extensions/hidetopbar/ > "$REPO_DIR/gnome/hidetopbar.dconf" 2>/dev/null || true
dconf dump /io/github/jeffshee/hanabi-extension/ > "$REPO_DIR/gnome/hanabi.dconf" 2>/dev/null || true

# Limpieza de archivos temporales de respaldo
find "$REPO_DIR/local/share/gnome-shell/extensions" -name "*.bak" -delete 2>/dev/null || true

cd "$REPO_DIR"
git status -s
echo -e "\e[1;32m[] Respaldo actualizado en $REPO_DIR.\e[0m"
