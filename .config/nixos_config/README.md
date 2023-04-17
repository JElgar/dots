sudo nixos-rebuild switch --flake .#jelgar

To remap keys:
https://unix.stackexchange.com/a/639163
```
gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources
```
