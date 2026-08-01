{ config, pkgs, ... }:

{
  # Zárt forráskódú firmware-ek engedélyezése (AMD GPU/Wi-Fi miatt szükséges)
  hardware.enableAllFirmware = true;
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  # GPU / Mesa / Vulkan beállítások
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
    ];
    extraPackages32 = with pkgs; [
    ];
  };

  # X11 / Wayland AMD driver
  services.xserver.videoDrivers = [ "amdgpu" ];
}
