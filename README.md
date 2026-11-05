# 󱇪 Spider-Man 2099 // LYLA Cyber-HUD Dotfiles (Arch Linux + GNOME)

Suite completa de personalización futurista inspirada en **Spider-Man 2099 (Miguel O'Hara)** y el asistente holográfico **LYLA** para **Arch Linux con GNOME**.

---

## 󰏖 ¿Qué incluye este repositorio?

- **`config/kitty/`**: Configuración de **Kitty Terminal** con efecto holográfico (blur/transparencia), estela de cursor neón carmesí (`#ff2a4b`), barra Powerline y paleta *Spider-Man 2099*.
- **`config/fastfetch/`**: Arte ASCII braille de Spider-Man + paneles de telemetría biométrica **`SPIDER-MAN 2099 // LYLA HUD`**.
- **`config/starship.toml`**: Prompt futurista con cápsulas `╭─󰯊 2099` y reloj `[LYLA // HH:MM:SS]`.
- **`config/gtk-3.0/` y `config/gtk-4.0/`**: Tema completo **SpiderMan-2099-Cyber** para aplicaciones GTK3, GTK4 y Libadwaita.
- **`local/share/gnome-shell/extensions/spider-hud@spiderman.2099/`**: Extensión nativa para GNOME Shell (45–51) que personaliza:
  - Barra superior con telemetría en vivo (`󱇪 2099 // LYLA [󰯊 CPU % | RAM %] SYNC`)
  - Centro de Calendario y Notificaciones con bordes neón carmesí y cian
  - Pantalla de bloqueo (aro de avatar neón, entrada de contraseña y reloj)
  - Dock / Dash y vista de actividades
- **`local/bin/spider-hud`**: Monitor táctico interactivo en terminal (`lyla` / `hud` / `spider-sense`) con radar y selector de trajes (`[M]` para cambiar entre *2099*, *Miles Morales* y *Symbiote*).
- **`local/bin/lyla-widget`**: Widget holográfico de escritorio en GTK4 + Cairo con radar arácnido rotatorio en vivo.
- **`wallpapers/`**: Fondos de pantalla Spider-Man 2099 y avatar circular para pantalla de bloqueo (`AccountsService`).
- **`gnome/`**: Volcados `dconf` de atajos de teclado, interfaz y preferencias de GNOME.

---

##  Cómo instalar en un dispositivo nuevo (o restaurar esta versión)

```bash
git clone https://github.com/victor22-te/Arch-Spidey-v1.git
cd Arch-Spidey-v1
chmod +x install.sh backup.sh
./install.sh
```

> El script `install.sh` instala automáticamente los paquetes faltantes en Arch Linux, copia todos los archivos, adapta las rutas a tu usuario actual y aplica los fondos, avatar y atajos de teclado.

---

## 󰕌 Cómo regresar a esta versión exacta si haces cambios después

El estado base estable está guardado bajo el tag **`v1.0-spiderman-2099`**:

```bash
cd ~/Proyectos/spiderman-2099-dotfiles
git checkout v1.0-spiderman-2099
./install.sh
```

---

## 󰋊 Cómo guardar nuevos cambios antes de hacer `git push`

Puedes ejecutar en cualquier momento:

```bash
cd ~/Proyectos/spiderman-2099-dotfiles
./backup.sh
git add .
git commit -m "Actualización de configuración"
git push
```

---

##  Atajos de Teclado Configurados

| Acción | Atajo Principal | Atajo Alternativo | Comando CLI |
| :--- | :--- | :--- | :--- |
| Abrir **Cyber-Terminal (Kitty)** | `Super + Enter` | `Ctrl + Alt + T` | `kitty` |
| Abrir **Monitor Táctico LYLA (TUI)** | `Super + S` | `Ctrl + Alt + S` | `lyla` / `hud` |
| Abrir **Widget Holográfico LYLA 2099** | `Super + H` | — | `lyla-deck` |
| Fondo 1: **Cráneo-Araña Neón 2099** | Botón en Widget | — | `spider-wall1` |
| Fondo 2: **Blueprint Alchemax 2099** | Botón en Widget | — | `spider-wall2` |
