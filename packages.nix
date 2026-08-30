{ config, pkgs, ... }:

{
  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  fonts.fontDir.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    libmtp
    adwaita-icon-theme
    pop-gtk-theme
    mtpfs
    bibata-cursors
    gamescope
    wofi
    grim
    wl-clipboard
    xwayland-satellite
    upower
    slurp
    ripgrep
    hx-lsp
    gtk3
    gtk4
    fzf
    lazygit
    mc
    webkitgtk_4_1
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    ffmpeg
    kitty
    wezterm
  ];

  environment.sessionVariables = {
    GST_PLUGIN_SYSTEM_PATH_1_0 = "/run/current-system/sw/lib/gstreamer-1.0";
  };
}
