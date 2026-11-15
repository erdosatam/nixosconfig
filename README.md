# nixosconfig

```BASH

git clone git@github.com:erdosatam/nixosconfig.git /etc/nixos/

nixos-rebuild switch --flake .#lenovo-ideapad

```

## Podman Distroboxban

A NixOS Podman modulja engedélyezi a felhasználói socketet a hoston:
`$XDG_RUNTIME_DIR/podman/podman.sock`. A Distroboxban a host rootless
Podmanjának használatához állítsd be a klienst:

```fish
set -gx CONTAINER_HOST "unix:///run/user/"(id -u)"/podman/podman.sock"
podman ps
```

Az itt indított konténerek a hoston futnak, ezért a bind mountok útvonalai
is a host fájlrendszerére vonatkoznak. A socket hozzáférést ad a felhasználó
Podman-konténereihez. A `dockerSocket` külön, rootful Docker-kompatibilis
socketet tesz elérhetővé.

Ha a socket hiányzik, a hoston ellenőrizhető a
`systemctl --user status podman.socket` paranccsal. Egy régi, már nem létező
Nix store útvonalra mutató felhasználói unit-link felülírhatja a NixOS unitját.
