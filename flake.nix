{
	description = "System flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs }: {
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				modules = [ ./configuration.nix ];
			};
		};
	};
}
