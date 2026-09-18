{ config, pkgs, ... }:

{
  # NetworkManager Wi-Fi energiatakarékosság kikapcsolása
  networking.networkmanager.wifi.powersave = false;

  # Ath10k driver opciók az eldobált kapcsolatok ellen
  boot.extraModprobeConfig = ''
    options ath10k_core skip_otp=y
    options ath10k_pci cryptmode=1
  '';

}
