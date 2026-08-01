{ config, pkgs, ... }:

{
  # Podman és Docker emuláció beállítása
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # podman-docker megfelelője NixOS-ben (docker parancs alias a podmanhoz)
    defaultNetwork.settings.dns_enabled = true;
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
    git
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
  ];
}
