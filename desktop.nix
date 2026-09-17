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

  systemd.tmpfiles.rules = [
    "d /usr/share/wallpapers 0755 root root -"
    "L+ /usr/share/wallpapers/login.png - - - - ${./wallpapers/login.png}"
    "L+ /usr/share/wallpapers/tgla_wall.png - - - - ${./wallpapers/tgla_wall.png}"
  ];

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      settings = {
        General = {
          Background = "/usr/share/wallpapers/login.png";
        };
      };
    };
    defaultSession = "plasma";
  };

  services.desktopManager.plasma6.enable = true;

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

  security.polkit.extraConfig = ''
  /* Újraindítás és leállítás engedélyezése a wheel csoportnak jelszó nélkül */
  polkit.addRule(function(action, subject) {
    if ((action.id == "org.freedesktop.login1.reboot" ||
         action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
         action.id == "org.freedesktop.login1.power-off" ||
         action.id == "org.freedesktop.login1.power-off-multiple-sessions") &&
        subject.isInGroup("wheel")) {
      return polkit.Result.YES;
    }
  });

  /* Flatpak rendszerfüggő műveletek engedélyezése a wheel csoportnak */
  polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.Flatpak.") === 0 &&
        subject.isInGroup("wheel")) {
      return polkit.Result.YES;
    }
  });
'';

  environment.systemPackages = with pkgs; [
   
  ];
}
