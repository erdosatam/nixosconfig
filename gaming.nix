{ config, pkgs, ... }:

{
  # Unfree csomagok engedélyezése a Steam miatt
  nixpkgs.config.allowUnfree = true;

  # Steam engedélyezése
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Vulkan Validation Layers és Gaming eszközök
  environment.systemPackages = with pkgs; [
    mangohud # Opcionális: FPS / hardware overlay
  ];
}
