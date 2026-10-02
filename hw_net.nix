{ config, pkgs, ... }:

{
  # NetworkManager Wi-Fi energiatakarékosság kikapcsolása
  networking.networkmanager.wifi.powersave = false;

  hardware.enableAllFirmware = true;

  # Ath10k driver opciók az eldobált kapcsolatok ellen
  boot.extraModprobeConfig = ''
    options ath10k_core skip_otp=y rawmode=y
    options ath10k_pci cryptmode=1 frame_mode=2
  '';

}
