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
						echo -e "\n🤷‍♂️ No changes detected"
					fi

					rm -rf ~/.cache/ksycoca6_*
					kbuildsycoca6
				fi
			'';
			update = "nix flake update /etc/nixos/";
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
		blender
	];
}
