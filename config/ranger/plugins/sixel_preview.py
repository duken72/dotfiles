# Image previews with SIXEL, for terminals without the kitty protocol (Windows Terminal >= 1.22).
# ranger 1.9.4 has no sixel method, so this adds one: set preview_images_method sixel
# Encodes with Pillow + numpy, no external tools.

from __future__ import (absolute_import, division, print_function)

import sys
from itertools import groupby

import numpy as np
from PIL import Image

from ranger.container.settings import ALLOWED_VALUES
from ranger.core.shared import FileManagerAware
from ranger.ext.img_display import (
    ImageDisplayer, ImageDisplayError, register_image_displayer, temporarily_moved_cursor)

# Windows Terminal maps sixel pixels onto a virtual 10x20 px cell (like a VT340) and scales
# that to the real font, so this is right for any font size there. Other terminals may differ.
CELL_W, CELL_H = 10, 20
COLORS = 128

ALLOWED_VALUES['preview_images_method'].append('sixel')


def encode_sixel(path, max_w, max_h):
    img = Image.open(path).convert("RGBA")
    img = Image.alpha_composite(Image.new("RGBA", img.size, "white"), img).convert("RGB")  # transparent -> white
    img.thumbnail((max_w, max_h))
    img = img.quantize(COLORS)
    pal = img.getpalette()[:COLORS * 3]
    pix = np.asarray(img)
    height, width = pix.shape

    out = ['\x1bPq"1;1;%d;%d' % (width, height)]
    for i in range(len(pal) // 3):
        r, g, b = (round(c * 100 / 255) for c in pal[i * 3:i * 3 + 3])
        out.append("#%d;2;%d;%d;%d" % (i, r, g, b))
    weights = (1 << np.arange(6))[:, None]
    for top in range(0, height, 6):
        band = pix[top:top + 6]
        for color in np.unique(band):
            # one sixel char per column: bit n is set if row n of the band has this colour
            bits = ((band == color) * weights[:len(band)]).sum(axis=0) + 63
            out.append("#%d" % color)
            for code, run in groupby(bits.tolist()):
                n = len(list(run))
                out.append("!%d%s" % (n, chr(code)) if n > 3 else chr(code) * n)
            out.append("$")
        out.append("-")
    out.append("\x1b\\")
    return "".join(out)


@register_image_displayer("sixel")
class SixelImageDisplayer(ImageDisplayer, FileManagerAware):
    def draw(self, path, start_x, start_y, width, height):
        try:
            sixel = encode_sixel(path, width * CELL_W, height * CELL_H)
        except Exception as ex:  # unreadable or unsupported image
            raise ImageDisplayError("sixel preview failed: %s" % ex)
        with temporarily_moved_cursor(start_y, start_x):
            sys.stdout.write(sixel)

    def clear(self, start_x, start_y, width, height):
        self.fm.ui.win.redrawwin()
        self.fm.ui.win.refresh()

    def quit(self):
        self.clear(0, 0, 0, 0)
