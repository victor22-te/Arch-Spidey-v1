import GLib from 'gi://GLib';
import Gio from 'gi://Gio';
import GObject from 'gi://GObject';
import St from 'gi://St';
import Clutter from 'gi://Clutter';

import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';
import * as PopupMenu from 'resource:///org/gnome/shell/ui/popupMenu.js';

const THEME_CSS = GLib.get_home_dir() + '/.themes/SpiderMan-2099-Cyber/gnome-shell/gnome-shell.css';

const SpiderHudIndicator = GObject.registerClass(
class SpiderHudIndicator extends PanelMenu.Button {
    _init() {
        super._init(0.0, 'Spider-Man 2099 Cyber-HUD', false);

        this._prevIdle = 0;
        this._prevTotal = 0;

        // Top Bar Box
        this._box = new St.BoxLayout({
            style_class: 'spider-hud-box',
        });

        this._badgeLabel = new St.Label({
            text: '🕷 2099 // LYLA',
            y_align: Clutter.ActorAlign.CENTER,
            style_class: 'spider-hud-badge',
        });

        this._telemetryLabel = new St.Label({
            text: '[🕸 CPU --% | RAM --%]',
            y_align: Clutter.ActorAlign.CENTER,
            style_class: 'spider-hud-telemetry',
        });

        this._senseLabel = new St.Label({
            text: '⚡SYNC',
            y_align: Clutter.ActorAlign.CENTER,
            style_class: 'spider-hud-sense-ok',
        });

        this._box.add_child(this._badgeLabel);
        this._box.add_child(this._telemetryLabel);
        this._box.add_child(this._senseLabel);
        this.add_child(this._box);

        this._buildMenu();
        this._updateMetrics();

        this._timeoutId = GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 2, () => {
            this._updateMetrics();
            return GLib.SOURCE_CONTINUE;
        });
    }

    _buildMenu() {
        // Header
        const headerItem = new PopupMenu.PopupBaseMenuItem({reactive: false});
        const headerBox = new St.BoxLayout();
        if ('orientation' in headerBox && Clutter.Orientation) {
            headerBox.orientation = Clutter.Orientation.VERTICAL;
        }

        headerBox.add_child(new St.Label({
            text: '🕸 ALCHEMAX // MIGUEL O’HARA CYBER-HUD v2099',
            style_class: 'spider-hud-menu-header',
        }));
        headerBox.add_child(new St.Label({
            text: 'LYLA Holographic Assistant: ONLINE • Nueva York 2099',
            style_class: 'spider-hud-menu-sub',
        }));
        headerItem.add_child(headerBox);
        this.menu.addMenuItem(headerItem);

        this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());

        // Live detailed telemetry item
        this._detailCpuItem = new PopupMenu.PopupMenuItem('  Núcleo Neural (CPU): Calculando...', {reactive: false});
        this._detailRamItem = new PopupMenu.PopupMenuItem('󰍛  Matriz de Memoria (RAM): Calculando...', {reactive: false});
        this._detailSenseItem = new PopupMenu.PopupMenuItem('⚡ Spider-Sense: Calibrado (Sin anomalías)', {reactive: false});
        this.menu.addMenuItem(this._detailCpuItem);
        this.menu.addMenuItem(this._detailRamItem);
        this.menu.addMenuItem(this._detailSenseItem);

        this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());

        // Quick Launchers
        const termItem = new PopupMenu.PopupMenuItem('🕸  Abrir Cyber-Terminal (Kitty)');
        termItem.connect('activate', () => {
            GLib.spawn_command_line_async('kitty');
        });
        this.menu.addMenuItem(termItem);

        const hudTuiItem = new PopupMenu.PopupMenuItem('⚡  Lanzar LYLA Tactical HUD (Monitor Interactivo)');
        hudTuiItem.connect('activate', () => {
            GLib.spawn_command_line_async('kitty --title "LYLA // SPIDER-MAN 2099 TACTICAL HUD" -e /home/spider-man/.local/bin/spider-hud');
        });
        this.menu.addMenuItem(hudTuiItem);

        const overviewItem = new PopupMenu.PopupMenuItem('🕷  Vista Táctica de Ventanas (Overview)');
        overviewItem.connect('activate', () => {
            Main.overview.toggle();
        });
        this.menu.addMenuItem(overviewItem);
    }

    _readFileContents(path) {
        try {
            const file = Gio.File.new_for_path(path);
            const [ok, bytes] = file.load_contents(null);
            if (ok) {
                const decoder = new TextDecoder('utf-8');
                return decoder.decode(bytes);
            }
        } catch (_e) {
            // ignore
        }
        return '';
    }

    _updateMetrics() {
        let cpuPct = 0;
        const statText = this._readFileContents('/proc/stat');
        if (statText) {
            const firstLine = statText.split('\n')[0];
            const parts = firstLine.trim().split(/\s+/).slice(1).map(n => parseInt(n, 10));
            if (parts.length >= 4) {
                const idle = parts[3] + (parts[4] || 0);
                const total = parts.reduce((a, b) => a + b, 0);
                const diffIdle = idle - this._prevIdle;
                const diffTotal = total - this._prevTotal;
                if (diffTotal > 0 && this._prevTotal > 0) {
                    cpuPct = Math.round(((diffTotal - diffIdle) / diffTotal) * 100);
                }
                this._prevIdle = idle;
                this._prevTotal = total;
            }
        }

        let ramPct = 0;
        let usedGb = '0.0';
        let totalGb = '0.0';
        const memText = this._readFileContents('/proc/meminfo');
        if (memText) {
            let memTotal = 0;
            let memAvail = 0;
            for (const line of memText.split('\n')) {
                if (line.startsWith('MemTotal:'))
                    memTotal = parseInt(line.split(/\s+/)[1], 10);
                else if (line.startsWith('MemAvailable:'))
                    memAvail = parseInt(line.split(/\s+/)[1], 10);
            }
            if (memTotal > 0) {
                const used = memTotal - memAvail;
                ramPct = Math.round((used / memTotal) * 100);
                usedGb = (used / 1048576).toFixed(1);
                totalGb = (memTotal / 1048576).toFixed(1);
            }
        }

        this._telemetryLabel.set_text(`[🕸 CPU ${cpuPct}% | RAM ${ramPct}%]`);

        if (cpuPct > 80 || ramPct > 85) {
            this._senseLabel.set_text('⚠ ALERTA');
            this._senseLabel.style_class = 'spider-hud-sense-alert';
            this._detailSenseItem.label.set_text('⚠ Spider-Sense: ¡ALERTA DE CARGA ALTA DETECTADA!');
        } else {
            this._senseLabel.set_text('⚡SYNC');
            this._senseLabel.style_class = 'spider-hud-sense-ok';
            this._detailSenseItem.label.set_text('⚡ Spider-Sense: Nominal (Red 2099 Estable)');
        }

        this._detailCpuItem.label.set_text(`  Núcleo Neural (CPU): ${cpuPct}% activo`);
        this._detailRamItem.label.set_text(`󰍛  Matriz de Memoria: ${usedGb} GB / ${totalGb} GB (${ramPct}%)`);
    }

    destroy() {
        if (this._timeoutId) {
            GLib.Source.remove(this._timeoutId);
            this._timeoutId = null;
        }
        super.destroy();
    }
});

export default class SpiderHudExtension extends Extension {
    enable() {
        // 1. Force-load custom Spider-Man 2099 Cyber-HUD GNOME Shell stylesheet
        try {
            const themeFile = Gio.File.new_for_path(THEME_CSS);
            if (themeFile.query_exists(null)) {
                Main.setThemeStylesheet(THEME_CSS);
                Main.loadTheme();
            }
        } catch (e) {
            console.error('Error applying 2099 shell theme stylesheet:', e);
        }

        // 2. Add Top Panel Telemetry & Menu Indicator
        try {
            this._indicator = new SpiderHudIndicator();
            Main.panel.addToStatusArea(this.uuid, this._indicator, 1, 'left');
        } catch (e) {
            console.error('Error creating 2099 status indicator:', e);
        }
    }

    disable() {
        if (this._indicator) {
            this._indicator.destroy();
            this._indicator = null;
        }

        try {
            Main.setThemeStylesheet(null);
            Main.loadTheme();
        } catch (e) {
            console.error('Error resetting shell stylesheet:', e);
        }
    }
}
