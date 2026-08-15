{ config, pkgs, ... }:

{
  # Zárt forráskódú firmware-ek engedélyezése (AMD GPU/Wi-Fi miatt szükséges)
  hardware.enableAllFirmware = true;
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  programs.corectrl = {
    enable = true;
  };

  hardware.amdgpu.overdrive.enable = true;

  # GPU / Mesa / Vulkan beállítások
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
      libva-vdpau-driver
      mesa
      vulkan-validation-layers
      vulkan-extension-layer
      vkd3d
      vulkan-tools
      vulkan-loader
      dxvk
    ];
    extraPackages32 = with pkgs; [
      pkgsi686Linux.libvdpau-va-gl
    ];
  };

  # X11 / Wayland AMD driver
  services.xserver.videoDrivers = [ "amdgpu" ];
}
