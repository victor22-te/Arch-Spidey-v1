# 󱇪 Spider-Man 2099 // LYLA Cyber-HUD Dotfiles (Arch Linux + GNOME)

Suite completa de personalización futurista inspirada en **Spider-Man 2099 (Miguel O'Hara)** y el asistente holográfico **LYLA** para **Arch Linux con GNOME Shell (Wayland/X11)**.

---

## 󰏖 ¿Qué incluye este repositorio?

- **`config/kitty/`**: Configuración de **Kitty Terminal** con efecto holográfico (blur/transparencia), estela de cursor neón carmesí (`#ff2a4b`), barra Powerline y paleta *Spider-Man 2099*.
- **`config/fastfetch/`**: Arte ASCII braille de Spider-Man + paneles de telemetría biométrica **`SPIDER-MAN 2099 // LYLA HUD`**.
- **`config/starship.toml`**: Prompt futurista con cápsulas `╭─󰯊 2099` y reloj `[LYLA // HH:MM:SS]`.
- **`config/gtk-3.0/` y `config/gtk-4.0/`**: Tema completo **SpiderMan-2099-Cyber** para aplicaciones GTK3, GTK4 y Libadwaita con acentos neón rojo/cian y modo oscuro forzado.
- **`local/share/gnome-shell/extensions/spider-hud@spiderman.2099/`**: Extensión nativa para GNOME Shell que personaliza:
  - Barra superior con telemetría en vivo (`󱇪 2099 // LYLA [󰯊 CPU % | RAM %] SYNC`)
  - Centro de Calendario y Notificaciones con bordes neón carmesí y cian
  - Pantalla de bloqueo (aro de avatar neón, entrada de contraseña y reloj)
  - Estilos Cyberpunk Alchemax para la interfaz
- **`local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/`**: Dock flotante centrado con parche exclusivo:
  - **Zero-Flicker Autohide / Intellihide**: Detección de puntero real que previene que el dock se oculte o parpadee mientras el cursor está encima.
  - **Previsualizaciones flotantes**: Menús contextuales de ventanas activas al pasar el cursor (hover preview) y ciclado fluido al hacer clic.
  - **Parche Wayland Direct Scanout**: Inhibición de des-redirección para evitar que la ventana maximizada vuelva invisible el dock.
- **`local/share/gnome-shell/extensions/hidetopbar@mathieu.bidon.ca/`**: Ocultación inteligente (Autohide / Intellihide) para la barra superior estilo dock: se oculta automáticamente para dejar la pantalla 100% limpia y reaparece al acercar el puntero al borde superior sin retardo (0ms).
- **`local/share/gnome-shell/extensions/hanabi-extension@jeffshee.github.io/`**: Fondos de pantalla animados (Live Wallpapers en video MP4 por hardware con GStreamer).
- **`local/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com/`**: Efectos holográficos y de fuego/glitch para apertura y cierre de ventanas con perfil Alchemax preconfigurado.
- **`local/share/gnome-shell/extensions/CoverflowAltTab@palatis.blogspot.com/`**: Conmutador de ventanas 3D estilo Coverflow.
- **`local/share/gnome-shell/extensions/caffeine@patapon.info/`**: Control rápido en la barra superior para evitar suspensión.
- **`local/bin/spider-hud`**: Monitor táctico interactivo en terminal (`lyla` / `hud` / `spider-sense`) con radar y selector de trajes (`[M]` para cambiar entre *2099*, *Miles Morales* y *Symbiote*).
- **`local/bin/lyla-widget`**: Widget holográfico de escritorio en GTK4 + Cairo con radar arácnido rotatorio en vivo.
- **`wallpapers/`**: Fondos estáticos y fondos de video animados (`spiderman_2099_live.mp4`, `nissan_live.mp4`) y avatar circular para pantalla de bloqueo (`AccountsService`).
- **`gnome/`**: Volcados `dconf` con todas las preferencias exactas de extensiones, temas, atajos y comportamiento de ventanas.

---

##  Cómo instalar en un sistema nuevo (o restaurar)

En cualquier equipo con **Arch Linux** y **GNOME**, abre la terminal y ejecuta:

```bash
git clone https://github.com/victor22-te/Arch-Spidey-v1.git
cd Arch-Spidey-v1
chmod +x install.sh backup.sh
./install.sh
```

> **¿Qué hace `install.sh` automáticamente?**
> 1. Instala los paquetes necesarios vía `pacman` (`kitty`, `fastfetch`, `starship`, `gstreamer`, fuentes, librerías GTK4, etc.).
> 2. Copia todas las extensiones, scripts, temas, fondos y configuraciones a tu carpeta de usuario.
> 3. Adapta las rutas internas si tu usuario no se llama `spider-man`.
> 4. Carga todos los volcados `dconf` para activar temas, atajos, Dash to Dock y Hanabi de inmediato.
> 5. Configura el avatar en la pantalla de inicio de sesión de GNOME.

---

## 󰋊 Cómo respaldar cambios y subirlos a GitHub

Si modificas algún tema, script, atajo o extensión en tu sistema, sincroniza el repositorio y súbelo a GitHub con estos 4 comandos:

```bash
cd ~/Proyectos/spiderman-2099-dotfiles
./backup.sh
git add -A
git commit -m "feat: actualizar configuraciones Spider-Man 2099"
git push origin main
```

---

##  Atajos de Teclado Configurados

| Acción | Atajo Principal | Atajo Alternativo | Comando CLI |
| :--- | :--- | :--- | :--- |
| Abrir **Cyber-Terminal (Kitty)** | `Super + Enter` | `Ctrl + Alt + T` | `kitty` |
| Abrir **Monitor Táctico LYLA (TUI)** | `Super + S` | `Ctrl + Alt + S` | `lyla` / `hud` |
| Abrir **Widget Holográfico LYLA 2099** | `Super + H` | — | `lyla-deck` |
| Conmutador de Ventanas 3D | `Alt + Tab` | — | — |
| Minimizar ventana activa | `Super + Flecha Abajo` | — | — |
| Panel de Control / Ajustes rápidos | `Super + Shift + S` | — | — |
