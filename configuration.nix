{ config, lib, pkgs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		./system-packages.nix
		./nvidia.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos";
	networking.networkmanager.enable = true;

	time.timeZone = "America/New_York";

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	services.xserver.videoDrivers = [ "nvidia" ];

	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
		settings = {
			General.DisplayServer = "wayland";
		};
	};

	services.desktopManager.plasma6.enable = true;

    systemd.services.rclone-bisync = {
      description = "rclone bisync";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        User = "rajwol";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone bisync /home/rajwol/OneDrive onedrive: \
            --exclude "Personal Vault/**" \
            --conflict-resolve newer \
            --resilient \
            --log-level INFO
        '';
        Type = "oneshot";
        OnFailure = "rclone-bisync-notify.service";
      };
    };

    systemd.timers.rclone-bisync = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "30s";
        OnUnitActiveSec = "30s";
      };
    };

    systemd.services.rclone-bisync-notify = {
      serviceConfig = {
        User = "rajwol";
        Type = "oneshot";
        Environment = "DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
        ExecStart = "${pkgs.libnotify}/bin/notify-send 'rclone bisync failed'";
      };
    };

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	users.defaultUserShell = pkgs.zsh;

	users.users.rajwol = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "docker"];
	};

	fonts.packages = with pkgs; [
		nerd-fonts.symbols-only
	];

	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		MOZ_USE_XINPUT2 = "1";
		EDITOR = "nvim";
	};

	environment.plasma6.excludePackages = with pkgs.kdePackages; [
		elisa
		konsole
		plasma-browser-integration
	];

	nix.settings = {
		trusted-users = [
			"rajwol"
		];
		experimental-features = [ "nix-command" "flakes" ];
	};

	system.stateVersion = "24.11"; # DO NOT CHANGE
}

