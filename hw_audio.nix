{ config, pkgs, ... }:

{
  # Realtime prioritás a felhasználóknak (audio csoporthoz)
  security.rtkit.enable = true;

  security.pam.loginLimits = [
    { domain = "*"; item = "rtprio"; type = "soft"; value = "99"; }
    { domain = "*"; item = "rtprio"; type = "hard"; value = "99"; }
    { domain = "*"; item = "memlock"; type = "soft"; value = "unlimited"; }
    { domain = "*"; item = "memlock"; type = "hard"; value = "unlimited"; }
  ];

  hardware.firmware = with pkgs; [
    alsa-firmware
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Low-latency konfiguráció kifejezetten a PipeWire-JACK-hez
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [ 44100 48000 88200 96000 ];
          "default.clock.quantum" = 128; # alacsony buffer méret a kis latency-ért
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 1024;
        };
      };
    };
  };

  # Kért szintetizátor és soundfont csomagok
  environment.systemPackages = with pkgs; [
    fluidsynth
    soundfont-fluid
  ];
}
