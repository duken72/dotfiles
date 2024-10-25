# README

<!-- vim-markdown-toc GFM -->

* [Fonts](#fonts)
* [Latex](#latex)
* [Printer](#printer)
* [Fun](#fun)

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

## Fun

- `sl`--a train in terminal
- `cmatrix`--a digital rain
- `asciiquarium`
- `wget https://raw.githubusercontent.com/mevdschee/2048.c/master/2048.c` then `gcc -o 2048 2048.c`
- `nudoku`
