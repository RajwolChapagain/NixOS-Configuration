{ config, pkgs, ... }:

{
	services.xserver.videoDrivers = [ "nvidia" ];

	hardware.graphics = {
		enable = true;
	};

	hardware.nvidia = {
		open = true;

		prime = {
			sync.enable = true;

			amdgpuBusId = "PCI:6:0:0";
			nvidiaBusId = "PCI:1:0:0";
		};

		modesetting.enable = true;
	};
}
