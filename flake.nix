# /etc/nixos/flake.nix
{
  description = "Saját NixOS konfiguráció";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # Cseréld ki a 'gépnév' értéket a saját hostname-edre
      lenovo-ideapad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
