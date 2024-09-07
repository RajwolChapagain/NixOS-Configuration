{
	description = "System flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixpkgs-24.05-darwin";
	};	

	outputs = { self, nixpkgs, ... }:
		let
			lib = nixpkgs.lib;
		in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				system = "x86_64-linux";
				modules = [ ./configuration.nix ];
			};
		};
	};

}
