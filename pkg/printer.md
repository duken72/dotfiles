# README

Notes on how to auto-detect and connect with printer in the network.

- Install and setup [`CUPS`](https://wiki.archlinux.org/title/CUPS)
  - Install: `usbutils`, `cups-pdf`
  - Start and enable `cups.service`
- To discover, make use of discovered or share printers using `DNS-SD`/`mDNS`, setup **.local hostname resolution** with Avahi and restart `cups.service`.
  - Install `nss-mdns`
  - Start/enable `avahi-daemon.service`
  - Edit the file `/etc/nsswitch.conf`
