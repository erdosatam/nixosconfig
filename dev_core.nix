{ config, pkgs, ... }:

{
  # Podman és Docker emuláció beállítása
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # podman-docker megfelelője NixOS-ben (docker parancs alias a podmanhoz)
    defaultNetwork.settings.dns_enabled = true;
  };

  # Fejlesztői konténer eszközök
  environment.systemPackages = with pkgs; [
    podman-compose
    toolbox
    git
    curl
    bash
    ripgrep-all
    fzf
    sassc
    nodejs
    papirus-icon-theme
    plymouth
    clang # C/C++ Compiler
    cmake
    ninja
    gdb
    valgrind
    gcc
    fd
    gnumake
    python3
    stylua
    shfmt
    unzip
    cargo
  ];
}
