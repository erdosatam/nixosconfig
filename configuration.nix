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
  programs.nm-applet.enable = false;

  environment.sessionVariables = {
    GDK_SCALE = "0.9";
    GDK_DPI_SCALE = "0.9";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland,x11";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
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

  security.polkit.enable = true;
  
  # Portálok és GTK támogatás biztosítása az ikonok átadásához
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };

  # VAGY a régi szintaxis (ha régebbi NixOS csatornán vagy):
  # (nerdfonts.override { fonts = [ "FiraCode" ]; })
  # Időzóna és Nyelv
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";

  # Wayland / swayfx session configuration with greetd.
  services.xserver.enable = false;
  programs.xwayland.enable = true;

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${lib.escapeShellArg "${pkgs.swayfx}/bin/sway --unsupported-gpu"}";
        user = "greeter";
      };
    };
  };

  security.pam.services.greetd.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.flatpak.app-install" ||
           action.id == "org.freedesktop.flatpak.app-uninstall" ||
           action.id == "org.freedesktop.flatpak.runtime-install" ||
           action.id == "org.freedesktop.flatpak.runtime-uninstall" ||
           action.id == "org.freedesktop.flatpak.modify-repo") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # 3. Automatikus Polkit Agent indítás Systemd User Service-ként
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
  
  users.users.greeter = {
    group = "greeter";
    linger = false;
    isSystemUser = true;
  };

  users.groups.greeter = {};

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
      "gamemode"
      "flatpak"
    ];
    shell = pkgs.fish;
  };

  services.gvfs = {
    enable = true;
    package = pkgs.gnome.gvfs;
  };
  # FUSE támogatás a felhasználói csatolásokhoz
  programs.fuse.userAllowOther = true;
  services.accounts-daemon.enable = true;
  services.tumbler.enable = true;    # Alternative/supplemental thumbnail generation
  hardware.sane.enable = true;       #
  services.upower.enable = true;
  # Rendszer szintű alap csomagok
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    pop-gtk-theme
    bibata-cursors
    swayfx
    swaybg
    swaylock
    waybar
    mako
    fuzzel
    networkmanagerapplet
    networkmanager_dmenu
    wofi
    mako
    grim
    slurp
    wl-clipboard
    upower
    xwayland-satellite
    libmtp
    mtpfs
  ];

  # Rendszer verzió (ne módosítsd telepítés után)
  system.stateVersion = "26.05";
}
