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

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      waybar
      mako
      dmenu
      foot
      wl-clipboard
      grim
      slurp
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  security.pam.services.greetd.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd ${pkgs.swayfx}/bin/sway";
        user = "greeter";
      };
    };
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
    swayfx
    swaybg
    swaylock
    waybar
    alacritty
    ironbar
    polkit_gnome
    thunar
    thunar-volman
    thunar-vcs-plugin
    thunar-archive-plugin
    networkmanagerapplet
    networkmanager_dmenu
    fuzzel
  ];
}
