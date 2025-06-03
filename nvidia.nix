{ config, pkgs, ... }:

{
	services.xserver.videoDrivers = [ "nvidia" ];

	hardware.graphics = {
		enable = true;
	};

	hardware.nvidia = {
		open = true;

		prime = {
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};

			amdgpuBusId = "PCI:6:0:0";
			nvidiaBusId = "PCI:1:0:0";
		};

		modesetting.enable = true;
	};
}
