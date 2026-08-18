{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./kernel.nix
    ./hw_gpu.nix
    ./hw_audio.nix
    ./dev_core.nix
    ./studio_apps.nix
    ./gaming.nix
    ./my_apps.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader alapbeállítás (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hálózat
  networking.hostName = "lenovo-ideapad";
  networking.networkmanager.enable = true;

  environment.sessionVariables = {
    GDK_SCALE = "0.9";
    GDK_DPI_SCALE = "0.9";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland,x11";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    XCURSOR_THEME = "Bibata-Original-Ice";
    XCURSOR_SIZE = "16";
  };

  environment.variables = {
    XCURSOR_THEME = "Bibata-Original-Ice";
    XCURSOR_SIZE = "16";
  };

  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name = Bibata-Original-Ice
    gtk-cursor-theme-size = 16
  '';

  environment.etc."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name = Bibata-Original-Ice
    gtk-cursor-theme-size = 16
  '';

  fonts.packages = with pkgs; [
  # Új, moduláris szintaxis (NixOS 24.05+)
  nerd-fonts.fira-code
  ];

  # /etc/nixos/configuration.nix
  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  # Portálok és GTK támogatás biztosítása az ikonok átadásához
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.pantheon.xdg-desktop-portal-pantheon ];
    config.common.default = "*";
  };

  # VAGY a régi szintaxis (ha régebbi NixOS csatornán vagy):
  # (nerdfonts.override { fonts = [ "FiraCode" ]; })
  # Időzóna és Nyelv
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";

  # Pantheon + LightDM: keep a single, non-conflicting login-manager setup.
  services.xserver.enable = true;
  programs.xwayland.enable = true;

  # Billentyűzet kiosztás
  services.xserver.xkb = {
    layout = "hu";
    variant = "";
  };

  # LightDM és Pantheon
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.defaultSession = "pantheon-wayland";
  services.desktopManager.pantheon.enable = true;

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
    ];
    shell = pkgs.fish;
  };

  services.accounts-daemon.enable = true;

  services.upower.enable = true;
  # Rendszer szintű alap csomagok
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    waypaper
    awww
    pantheon-tweaks
    swaylock
    adwaita-icon-theme 
    bibata-cursors
    upower
    pavucontrol
    wofi
    xwayland-satellite
  ];

  # Rendszer verzió (ne módosítsd telepítés után)
  system.stateVersion = "26.05";
}
