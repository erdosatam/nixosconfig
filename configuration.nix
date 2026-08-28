{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./kernel.nix
    ./hw_gpu.nix
    ./hw_audio.nix
    ./dev_core.nix
    ./studio_apps.nix
    ./gaming.nix
    ./packages.nix
    ./flatpak.nix
    ./cosmic-desktop.nix
  ];

  environment.sessionVariables = {
    GDK_SCALE = "0.9";
    GDK_DPI_SCALE = "0.9";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland,x11";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XCURSOR_THEME = "Bibata-Original-Ice";
    XCURSOR_SIZE = "16";
  };



  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader alapbeállítás (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hálózat
  networking.hostName = "lenovo-ideapad";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = false;

  # Időzóna és Nyelv
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";

  # Fish shell engedélyezése rendszer szinten
  programs.fish.enable = true;

  # Felhasználó beállításai
  users.users.erdosa = {
    isNormalUser = true;
    description = "erdosa";
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "audio" 
      "video" 
      "realtime"
      "pipewire"
      "podman"
      "docker"
      "gamemode"
      "flatpak"
    ];
    shell = pkgs.fish;
  };

  # Rendszer verzió (ne módosítsd telepítés után)
  system.stateVersion = "26.05";
}
