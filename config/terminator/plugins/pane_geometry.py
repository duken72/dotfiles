"""Terminator plugin: tells over dbus where a terminal is drawn.

~/.dotfiles/bin/ueberzug uses it to put ranger's image previews into the right window
and pane. Enable it with "enabled_plugins = PaneGeometry" in [global_config].
"""

import dbus.service
from gi.repository import Gtk

from terminatorlib import plugin
from terminatorlib.terminator import Terminator

AVAILABLE = ['PaneGeometry']

DBUS_PATH = '/net/tenshu/Terminator2/PaneGeometry'
DBUS_INTERFACE = 'net.tenshu.Terminator2.PaneGeometry'


class PaneGeometry(plugin.Plugin, dbus.service.Object):
    """Served on Terminator's own bus name ($TERMINATOR_DBUS_NAME)"""
    capabilities = ['pane_geometry']

    def __init__(self):
        plugin.Plugin.__init__(self)
        dbus.service.Object.__init__(self, dbus.SessionBus(), DBUS_PATH)

    def unload(self):
        self.remove_from_connection()

    @dbus.service.method(DBUS_INTERFACE, in_signature='s', out_signature='(uiiiib)')
    def get(self, uuid):
        """Return (X11 window id, x and y of the text origin inside that window,
        cell width, cell height, visible) of the terminal with $TERMINATOR_UUID uuid,
        in device pixels. Hidden tabs and zoomed-away panes are not visible."""
        vte = Terminator().find_terminal_by_uuid(uuid).vte
        window = vte.get_toplevel()
        x, y = vte.translate_coordinates(window, 0, 0)
        padding = vte.get_style_context().get_padding(Gtk.StateFlags.NORMAL)
        scale = vte.get_scale_factor()
        return (window.get_window().get_xid(),
                (x + padding.left) * scale, (y + padding.top) * scale,
                vte.get_char_width() * scale, vte.get_char_height() * scale,
                vte.get_mapped())
