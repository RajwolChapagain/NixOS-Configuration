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
			ec = "sudo nvim /etc/nixos/configuration.nix";
			ep = "sudo nvim /etc/nixos/system-packages.nix";
			# The cache clearing + kbuildsycoc6 updates application menu links
			rebuild = ''
				sudo nixos-rebuild switch |& nom
				rm -rf ~/.cache/ksycoca6_*
				kbuildsycoca6
			'';
			update = "sudo nix flake update /etc/nixos/";
			ssh = "kitten ssh";
		};
		promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	};

	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
		flags = [ "--cmd cd" ];
	};

	programs.obs-studio.enable = true;

	programs.bat.enable = true;

	environment.systemPackages = with pkgs; [
		neovim
		git
		kitty
		thunderbird
		keepassxc
		eza
		zsh-powerlevel10k
		godot
		github-desktop
		vlc
		signal-desktop
		inkscape
		adwaita-icon-theme
		krita
		nix-output-monitor
	];
}
