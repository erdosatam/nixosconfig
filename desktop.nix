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

  services.blueman.enable = true;

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };

  programs.xwayland.enable = true;

  services.desktopManager.cosmic.enable = true;
  services.displayManager = {
    defaultSession = "cosmic";
    cosmic-greeter.enable = true;
  };

  services.xserver.xkb = {
    layout = "hu";
    variant = "";
  };

  services.gvfs = {
    enable = true;
    package = pkgs.gnome.gvfs;
  };

  programs.fuse.userAllowOther = true;
  services.accounts-daemon.enable = true;
  services.tumbler.enable = true;
  hardware.sane.enable = true;
  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-ext-applet-caffeine
    cosmic-ext-tweaks
    cosmic-ext-applet-sysinfo
    cosmic-monitor
    cosmic-ext-calculator
    cosmic-ext-ctl
    cosmic-applets
  ];
}