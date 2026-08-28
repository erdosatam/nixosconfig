{ config, pkgs, lib, ... }:

{
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
    nerd-fonts.fira-code
  ];

  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.common.default = "*";
  };

  services.xserver.enable = true;
  programs.xwayland.enable = true;

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "plasma";

  services.xserver.xkb = {
    layout = "hu";
    variant = "";
  };

  services.gvfs.enable = true;
  programs.fuse.userAllowOther = true;
  services.accounts-daemon.enable = true;
  services.tumbler.enable = true;
  hardware.sane.enable = true;
  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.kdeconnect-kde
    kdePackages.plasma-workspace
  ];
}
