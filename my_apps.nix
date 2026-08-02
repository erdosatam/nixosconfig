{ config, pkgs, ... }:

{

# Flatpak engedélyezése
  services.flatpak.enable = true;

  # XDG Desktop Portal engedélyezése (szükséges az ablakintegrációhoz és fájlkezelőkhöz)
  environment.systemPackages = with pkgs; [
    # Ide írhatod a saját mindennapi alkalmazásaidat
    # Pl.: firefox, neovim, vlc, mpv, stb.
   	vim
	neovim
	firefox
	flatpak
	flatpak-xdg-utils
	mc
	webkitgtk_4_1
	gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good     # Open-source, high-quality plugins
    	gst_all_1.gst-plugins-bad      # Quality plugins lacking documentation/review
	gst_all_1.gst-plugins-ugly     # Quality plugins with distribution/patent issues (e.g., MP3, AAC)
    	gst_all_1.gst-libav            # FFmpeg-based wrapper plugin (codecs support)
    	gst_all_1.gst-vaapi            # Hardware acceleration (VA-API for Intel/AMD graphics)
	ffmpeg
	arc-kde-theme
	arc-theme
  ];
  environment.sessionVariables = {
    GST_PLUGIN_SYSTEM_PATH_1_0 = "/run/current-system/sw/lib/gstreamer-1.0";
  };
}
