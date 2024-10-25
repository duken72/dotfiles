# README

<!-- vim-markdown-toc GFM -->

* [Fonts](#fonts)
* [Latex](#latex)
* [Printer](#printer)
* [Bluetooth](#bluetooth)
* [Fun](#fun)
* [Setting up `GPU` for deep learning](#setting-up-gpu-for-deep-learning)
* [Customization](#customization)
  * [Old customization](#old-customization)

<!-- vim-markdown-toc -->

## Fonts

You need this font packages to display text correctly in `brave` web-browser.

- `adobe-source-han-sans-otc-fonts` for Chinese, Japanese, Korean
- `noto-fonts-emoji` for emoji icons

## Latex

Check [Arch Wiki](https://wiki.archlinux.org/title/TeX_Live).

- `texlive-basic`, the core installation, based on the medium upstream install scheme. The package includes `pacman` hooks to automate `mktexlsr`, `fmtutil` and `updmap`.
- `texlive-latex` contains essential `LaTeX` packages.
- `texlive-latexrecommended` and `texlive-latexextra` contain many useful LaTeX packages, such as `polyglossia`, `amsmath` and `graphicx`.
- `texlive-fontsrecommended` contains essential fonts, which include the default `Latin Modern`.
  - `texlive-fontsextra`, `texlive-fontsutils` contain fonts, which you can view on the `LaTeX` Font Catalogue.
- `texlive-xetex` and `texlive-luatex` contain packages for `XeTeX` and `LuaTeX` respectively.
- `texlive-bibtexextra` contains the BibLaTeX package and `BibTeX` styles and bibliography databases.
- `texlive-mathscience` contains essential packages for mathematics, natural sciences and computer science.
- `texlive-lang` group contains packages providing character sets and features for languages with non-Latin characters.
  - `texlive-langgreek` as the dependencies for `textgreek`
- `texlive-binextra` for `latexmk`, which automatically compile `.tex` file
  - install `biber` too
- If you miss specific `.sty` files, you can run `pacman -F` to find the Arch package that provides them
- `latexmk`

  ```bash
  latexmk -pdf
  latexmk -pvc
  ```

## Printer

Notes on how to auto-detect and connect with printer in the network.

- Install and setup [`CUPS`](https://wiki.archlinux.org/title/CUPS)
  - Install: `usbutils`, `cups-pdf`
  - Start and enable `cups.service`
- To discover, make use of discovered or share printers using `DNS-SD`/`mDNS`, setup `.local hostname resolution` with `Avahi` and restart `cups.service`.
  - Install `nss-mdns`
  - Start/enable `avahi-daemon.service`
  - Edit the file `/etc/nsswitch.conf`

## Bluetooth

- Install: `bluez`, `bluez-utils`, `pulseaudio-bluetooth`
- [Issue: br-connection-profile-unavailable](https://bbs.archlinux.org/viewtopic.php?id=270465)

## Fun

- `sl`--a train in terminal
- `cmatrix`--a digital rain
- `asciiquarium`
- `wget https://raw.githubusercontent.com/mevdschee/2048.c/master/2048.c` then `gcc -o 2048 2048.c`
- `nudoku`

## Setting up `GPU` for deep learning

Follow this [guide](https://jaggu-iitm.medium.com/setting-up-deep-learning-with-cuda-tensorflow-and-keras-on-arch-linux-with-dual-gpu-nvidia-gpu-82963d2ecb75)

- You don't need to install and use `bumblebee`, `optimus-manager` or `prime` to use the GPU, from either Intel or NVIDIA, for DL with `pytorch`/`tensorflow`

  ```bash
  sudo pacman -S cuda cudnn nvidia-dkms nvidia-utils \
      python-tensorflow-opt-cuda python-pytorch-opt-cuda
  ```

- Check in Python:

  ```python
  from tensorflow.python.client import device_lib
  device_lib.list_local_devices()
  import tensorflow as tf
  tf.config.list_physical_devices('GPU')

  import torch
  torch.cuda.is_available()
  ```

## Customization

- [Steam custom Proton GE](https://github.com/GloriousEggroll/proton-ge-custom#native)
- Window manager theme: [True Minimalist](https://www.xfce-look.org/p/1016640/) and [guide to install](https://wiki.xfce.org/howto/install_new_themes)
- Fonts: [JetBrainsNL Mono Nerd](https://archlinux.org/packages/community/any/ttf-jetbrains-mono-nerd/), size 11-12
- Mouse cursor: [Night Diamond theme](https://www.gnome-look.org/p/1295073/) and [Wiki guide](https://wiki.archlinux.org/title/Cursor_themes#XFCE)
- [Move between monitors](https://github.com/calandoa/movescreen)
- [Redshift](https://wiki.archlinux.org/title/redshift) and [Backlight](https://wiki.archlinux.org/title/backlight)
- Unibus-vn: [enable macro](https://github.com/vn-input/ibus-unikey/issues/11)
- [`polybar`](https://github.com/polybar/polybar): check wiki, also nice reference from [AbdelrhmanNile](https://github.com/AbdelrhmanNile/mydots_bspwm)
- Ranger: [image preview with `ueberzug`](https://github-wiki-see.page/m/ranger/ranger/wiki/Image-Previews), [video thumbnail with `ffmpeg`](https://www.reddit.com/r/NixOS/comments/74wftw/video_previews_wranger/), [docx2txt](http://docx2txt.sourceforge.net/)
- `zsh` with terminator and [Powerlevel10k](https://dev.to/web3coach/best-terminal-setup-terminator-zsh-powerlevel10k-7pl)
- Missing keyboard volume control: [Arch wiki](https://wiki.archlinux.org/title/Keyboard_input) and [pulseaudio-ctl](https://github.com/graysky2/pulseaudio-ctl) get the key code with `showkey`, then setup keyboard shortcut to a `pulseaudio-ctl` command
- Replacement for `G-HUB`: [`Libratbag`](https://womanonrails.com/logitech-g915-tkl), and maybe [piper](https://github.com/libratbag/piper) as frontend app
- Setting up [cleaning hooks](https://averagelinuxuser.com/clean-arch-linux/#1-clean-package-cache)
- [`pacman` Tips and tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Back_up_the_pacman_database)

### Old customization

- Terminus fonts as console font: put `vconsole.conf` in `/etc`
- email client in terminal: [Alpine](https://alpineapp.email/) [bcacciaaudio.com](https://bcacciaaudio.com/2018/10/09/alpine-mail-setup-with-gmail/), [salixos.org](https://docs.salixos.org/wiki/How_to_set_up_Alpine_with_a_Gmail_account), [linuxshelltips.com](https://www.linuxshelltips.com/alpine-gmail-imap-in-linux/), [wesleyac.com](https://blog.wesleyac.com/posts/setting-up-alpine-gmail-with-arch-linux)
- Desktop system monitoring: [`conky`](https://github.com/brndnmtthws/conky), a fork from [`xypnox`](https://github.com/xypnox/dotfiles)
- Download manager: [`xdman`](https://xtremedownloadmanager.com/), [youtube-dl](https://youtube-dl.org/)
- A bit troublesome with the [`Osmos` theme](https://github.com/Warinyourself/lightdm-webkit-theme-osmos)
