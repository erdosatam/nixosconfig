{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # Ide írhatod később a stúdió / zeneszerkesztő alkalmazásokat
    # Pl.: ardour, reaper, lmms, carla, stb.
    qpwgraph
  ];
}
