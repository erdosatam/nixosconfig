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
  };
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
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # VAGY a régi szintaxis (ha régebbi NixOS csatornán vagy):
  # (nerdfonts.override { fonts = [ "FiraCode" ]; })
  # Időzóna és Nyelv
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "hu_HU.UTF-8";

  # Niri Wayland session with greetd
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
      user = "greeter";
    };
  };

  # Billentyűzet kiosztás
  services.xserver.xkb = {
    layout = "hu";
    variant = "";
  };

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
    ];
    shell = pkgs.fish;
  };

  # Rendszer szintű alap csomagok
  environment.systemPackages = with pkgs; [
    ags
    fuzzel
    xwayland-satellite
  ];

  # Rendszer verzió (ne módosítsd telepítés után)
  system.stateVersion = "26.05";
}
