# Copyright (c) 2021, Huu Duc Nguyen
# All rights reserved.

# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# -------------------------------------------------

cat -n [file.txt]
more [file.txt]
head -n [no_rows] [file.txt]
tail -n [no_rows] [file.txt]

less [file.txt]

# -------------------------------------------------
# NAVIGATION
#  e  ^E  j  ^N      *  Forward  one line   (or N lines).
#  d  ^D             *  Forward  one half-window (and set half-window to N).
#  f  ^F  ^V  SPACE  *  Forward  one window (or N lines).
#  F                    Forward forever; like "tail -f".
#  y  ^Y  k  ^K      *  Backward one line   (or N lines).
#  b  ^B  ESC-v      *  Backward one window (or N lines).
#  u  ^U             *  Backward one half-window (and set half-window to N).
#  g                 *  Go to first line in file (or line N).
#  G                 *  Go to last line in file (or line N).
# SEARCHING
#  /pattern          *  Search forward for (N-th) matching line.
#  ?pattern          *  Search backward for (N-th) matching line.
#  n                 *  Repeat previous search (for N-th occurrence).
#  N                 *  Repeat previous search in reverse direction.
#  ESC-u                Undo (toggle) search highlighting.
# EDITING
#  v                 *  Edit
#  s                 *  Save
#  h                 *  Display help
#  q  :q  Q  :Q  ZZ  *  Exit