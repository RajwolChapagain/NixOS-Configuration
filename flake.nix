{
    description = "System flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable }:
        let
        system = "x86_64-linux";

    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
    };

    pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
    };
    in
    {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            inherit system;

            specialArgs = {
                inherit pkgs-unstable;
            };

            modules = [
                ./configuration.nix
            ];
        };
    };
}
