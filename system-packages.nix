{ config, pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	programs.steam.enable = true;

	programs.firefox = {
		enable = true;
		preferences = {
			"widget.use-xdg-desktop-portal.file-picker" = 1;
			"media.hardware-video-decoding.force-enabled" = true;
		};
	};

	programs.dconf.enable = true;

	programs.zsh = {
		enable = true;
		shellAliases = {
			ls = "eza --icons";
		};
	};

	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
		flags = [ "--cmd cd" ];
	};

	environment.systemPackages = with pkgs; [
		neovim
			git
			kitty
			thunderbird
			keepassxc
			eza
	];
}
