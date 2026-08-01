{ config, pkgs, ... }:

{

  boot.kernelPackages = pkgs.linuxPackages_latest;


  # Kernel paraméterek
  boot.kernelParams = [
    "amdgpu.dpm=1"
    "amdgpu.runpm=1"
    "amdgpu.dc=1"
    "amdgpu.audio=0"
    "preempt=full"
    "mitigations=off"
    "threadirqs"
  ];

  services.power-profiles-daemon.enable = false;

  # TLP Power Management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_HWP_ON_AC = "performance";
    };
  };
}
