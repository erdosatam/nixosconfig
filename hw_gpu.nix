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
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs; [
      pkgsi686Linux.libvdpau-va-gl
    ];
  };

  # X11 / Wayland AMD driver
  services.xserver.videoDrivers = [ "amdgpu" ];
}
