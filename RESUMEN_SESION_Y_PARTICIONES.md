# 󱇪 Resumen de Sesión: Spider-Man 2099 // LYLA HUD & Diagnóstico de Particiones Ubuntu (NVMe)

**Fecha:** 4 de noviembre de 2026  
**Repositorio:** `/home/spider-man/Proyectos/spiderman-2099-dotfiles`

---

## 1. Cambios Realizados y Aplicados en Arch Linux

### A. Eliminación Total de Emojis Coloridos → Iconos Vectoriales Monocromáticos (Nerd Font)
Se reemplazaron todos los emoticones de Unicode (`🕷`, `🕸`, `⚡`, `🖼`, `⚠`, `✔`) por glifos vectoriales planos de **`JetBrainsMono Nerd Font`** que adoptan el color exacto de la interfaz:
- `󱇪` (`U+F11EA`) — Araña monocromática
- `󰯊` (`U+F0BCA`) — Telaraña geométrica
- `` (`U+F0E7`) — Rayo / Pulso táctico
- `` (`U+F2DB`) — Microprocesador (CPU)
- `󰍛` (`U+F035B`) — Matriz de Memoria (RAM)
- `󰐷` (`U+F0437`) — Radar / Monitor Táctico
- `` (`U+F120`) — Cyber-Terminal
- `󰋩` (`U+F02E9`) — Selector de Fondo
- `` (`U+F071`) — Alerta de carga

**Archivos actualizados:**
- `local/share/gnome-shell/extensions/spider-hud@spiderman.2099/extension.js`
- `local/bin/lyla-widget`
- `local/bin/spider-hud`
- `config/starship.toml`
- `config/fastfetch/config.jsonc`
- `config/kitty/kitty.conf`
- `install.sh`, `backup.sh` y `README.md`

### B. Rediseño y Ajuste del Reloj de Pantalla de Bloqueo
- Se eliminó el estilo neón rojo/cian difuso de la pantalla de bloqueo.
- Se aplicó un acabado sobrio y futurista:
  - **Hora (`.unlock-dialog-clock-time`)**: Blanco hielo (`#f1f5f9`), `5.2em`, sin `letter-spacing` que provocaba recorte (`...`), con `padding: 0 20px` y sombra oscura sutil.
  - **Fecha (`.unlock-dialog-clock-date`)**: Gris acero (`#94a3b8`), `1.4em`, `padding: 0 16px`.

### C. Video para Fondo Animado (Hanabi)
Tu video descargado (`spiderman-8.mp4`, 38.4 MB, 16:9) ya quedó guardado y respaldado en:
1. `/home/spider-man/Vídeos/spiderman_2099_live.mp4`
2. `/home/spider-man/Proyectos/spiderman-2099-dotfiles/wallpapers/spiderman_2099_live.mp4`

---

## 2. Diagnóstico del Disco `nvme0n1` (¿Por qué Ubuntu aparece dividido?)

Al revisar la tabla de particiones de tu disco principal **NVMe de 1 TB (`nvme0n1` — 953.9 GB)** se encontró esta distribución exacta:

| Partición | Tipo / Sistema de Archivos | Tamaño | Contenido Detectado |
| :--- | :--- | :--- | :--- |
| `nvme0n1p1` | `vfat` | `100 MB` | Partición EFI (`/boot/efi`) |
| `nvme0n1p2` | `ext4` | `475 GB` | **Arch Linux (`/`)** |
| **`nvme0n1p3`** | **`LVM2_member`** | **`228 GB`** | **Volumen LVM sin cifrar (mitad de tu espacio de Ubuntu)** |
| **`nvme0n1p5`** | **`ext4`** | **`2 GB`** | **`/boot` de Ubuntu** (contiene `vmlinuz-7.0.0-42-generic` y `grub` con fecha del 4 de nov) |
| **`nvme0n1p6`** | **`crypto_LUKS`** | **`248 GB`** | **Contenedor cifrado LUKS (la otra mitad del medio tera)** |

### ¿Qué pasó con el medio tera (~478 GB) de Ubuntu?
La suma de **`nvme0n1p3` (228 GB)** + **`nvme0n1p5` (2 GB)** + **`nvme0n1p6` (248 GB)** da exactamente **`478 GB` (~medio tera)**.

Están separadas en dos bloques grandes dentro del NVMe:
1. **`nvme0n1p3` (`228 GB`, `LVM2_member`)**: Es un volumen lógico LVM que **no está cifrado con LUKS**, pero no aparece automáticamente en el gestor de archivos de Arch si el servicio `lvm2` no ha activado los grupos de volúmenes (`sudo vgchange -ay`).
2. **`nvme0n1p6` (`248 GB`, `crypto_LUKS`)**: Es una partición cifrada con LUKS. Cuando el instalador de Ubuntu se ejecuta con la opción de *"Cifrar la instalación con LVM y LUKS"*, crea una partición `/boot` de 2 GB (`nvme0n1p5`) y una partición `crypto_LUKS` (`nvme0n1p6`).
   - **Nota sobre la contraseña de LUKS**: La contraseña que pide al hacer clic en el volumen de 248 GB es la **Frase de paso de cifrado de disco (LUKS Security Key)** (o si la contraseña lleva caracteres especiales, revisa si durante el instalador de Ubuntu el teclado estaba en **Inglés `us`** en vez de **Español `latam`**).

---

## 3. Qué hacer cuando entres a Ubuntu (o desde Arch)

### Si entras a Ubuntu:
1. Copia tu carpeta de la extensión Hanabi modificada:
   ```bash
   ~/.local/share/gnome-shell/extensions/hanabi-extension@jeffshee.github.io
   ```
2. Puedes guardarla en una memoria USB, subirla a un repo de GitHub, o copiarla directamente a la partición de **Arch Linux (`475 GB` `nvme0n1p2`)** dentro de:
   ```text
   /home/spider-man/Proyectos/spiderman-2099-dotfiles/
   ```
3. También en Ubuntu ejecuta `lsblk -f` en una terminal para ver cuál de las dos particiones (`nvme0n1p3` de 228 GB o `nvme0n1p6` de 248 GB) está montada como `/` en ese Ubuntu.

### Si quieres montar el LVM de 228 GB (`nvme0n1p3`) desde Arch Linux:
```bash
sudo vgchange -ay
lsblk -f
```
Eso activará cualquier volumen de Ubuntu dentro de `nvme0n1p3` y aparecerá en `/dev/mapper/` listo para montarse sin pedir contraseña LUKS.
