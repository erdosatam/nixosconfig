{ config, pkgs, ... }:

{
  # Podman és Docker emuláció beállítása
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # podman-docker megfelelője NixOS-ben (docker parancs alias a podmanhoz)
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.containers.containersConf.settings = {
    engine = {
      cgroup_manager = "cgroupfs";
      # Ha a crun továbbra is hibát adna, átválthatsz runc-ra is:
     # runtime = "runc";
  };
  };

  virtualisation.containers = {
    enable = true;

    # Configure default search registries for podman/toolbox
    registries.search = [
      "docker.io"
      "quay.io"
      "registry.fedoraproject.org"
      "registry.access.redhat.com"
    ];
  };

  boot.kernel.sysctl = {
    "user.max_user_namespaces" = 28633;
    "kernel.unprivileged_userns_clone" = 1;
  };

  # Enable subuid/subgid mapping for rootless containers
  users.extraUsers.erdosa = {
    isNormalUser = true;
    extraGroups = [ "podman" ];
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };


  # Fejlesztői konténer eszközök
  environment.systemPackages = with pkgs; [
    podman
    podman-compose
    distrobox
    direnv
    git
    glib
    glib.dev
    curl
    bash
    ripgrep-all
    fzf
    sassc
    nodejs
    papirus-icon-theme
    plymouth
    clang # C/C++ Compiler
    cmake
    ninja
    gdb
    valgrind
    gcc
    fd
    gnumake
    python3
    stylua
    shfmt
    unzip
    cargo
    cairo
    python3Packages.pycairo
    pkg-config
  ];
}
