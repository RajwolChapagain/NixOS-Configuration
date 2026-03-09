{
	description = "System flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
	};

	outputs = { self, nixpkgs }: {
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				modules = [ ./configuration.nix ];
			};
		};
	};
}
