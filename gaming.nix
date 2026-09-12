{ config, pkgs, ... }:

{
  # Unfree csomagok engedélyezése a Steam miatt
  nixpkgs.config.allowUnfree = true;

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };

  services.ananicy = {
  enable = true;
  package = pkgs.ananicy-cpp;
  rulesProvider = pkgs.ananicy-cpp;
  };


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
