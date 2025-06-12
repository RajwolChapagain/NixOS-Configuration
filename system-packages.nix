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
			ec = "nvim /etc/nixos/configuration.nix";
			ep = "nvim /etc/nixos/system-packages.nix";

			# Lots of funky things happening inside this rebuild alias.
			# So, here's a breakdown:

			# ➤ We do "sudo true" first because if we don't, then nom
			#	supresses the sudo password input prompt if we use sudo
			#	for the first time in "sudo nixos-rebuild switch |& nom".
			# ➤ "set -o pipefail" causes "$?" to account for the error code
			#	of "sudo nixos-rebuild switch" instead of just nom's to
			#	which its output is piped.
			# ➤ "rm -rf ~/.cache/ksycoca6_*" followed by "kbuildsycoca6" 
			#	rebuild the kde application menu cache, which fixes 
			#	broken menu items on rebuild.
			rebuild = ''
				sudo true

				set -o pipefail
				sudo nixos-rebuild switch |& nom

				if [[ $? -eq 0 ]]; then
					echo -e "\n🎉 Rebuild successful!"

					git -C /etc/nixos diff --quiet

					if [[ $? -ne 0 ]]; then
						echo -e "\n🗒️ Summary of changes: "
						git -C /etc/nixos diff

						echo -e "\n💬 Enter a commit message: "
						read commit_msg
						
						if [[ -n "$commit_msg" ]]; then
							git -C /etc/nixos/ add .
							git -C /etc/nixos/ commit -m "$commit_msg"
							git -C /etc/nixos/ push
						else
							echo -e "\n✏️ No commit message provided. Skipping commit."
						fi
					else
						echo -e "🤷‍♂️ No changes detected.\n"
					fi

					rm -rf ~/.cache/ksycoca6_*
					kbuildsycoca6
				fi
			'';
			update = "nix flake update --flake /etc/nixos/";
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

	programs.git = {
		enable = true;
		config = {
			init.defaultBranch = "main";
		};
	};

	programs.kdeconnect.enable = true;

	programs.neovim = {
		enable = true;
		configure.customRC = ''
			set number
			set relativenumber
			set tabstop=4
			set shiftwidth=4
			colorscheme lunaperche
			set foldmethod=marker
			set foldmarker=<<<,>>>
		'';
	};

	virtualisation.podman = {
		enable = true;
		dockerCompat = true;
	};

	environment.systemPackages = with pkgs; [
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
		zoom-us
		protonvpn-gui
		kdePackages.kcalc
		unityhub
		distrobox
		vscode
		prismlauncher
		libreoffice
	];
}
