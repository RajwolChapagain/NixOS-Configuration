{ config, pkgs, ...}:
{
    nixpkgs.config.allowUnfree = true;
 
    environment.systemPackages = with pkgs; [
	neovim
	neofetch
	git
	gcc
	clang-tools
	gdb
	bat
	tldr
	firefox
	thunderbird
	keepassxc
	signal-desktop
	kate
	bibata-cursors
	davinci-resolve
	vscode
	python3
	jetbrains.pycharm-community
	godot_4
	libreoffice-qt-fresh
	mangohud
	gamemode
	goverlay
	obs-studio
	vlc
	mpg123 
	gimp
	inkscape
	github-desktop
	tenacity
	zoom-us
	zoxide
	fzf
	zsh-powerlevel10k
	kdePackages.kcalc
	blanket
	lutris
	krita
	slack
	blender
	gnome.adwaita-icon-theme
	scrcpy
	wl-clipboard
	atlauncher
	jdk
      ];
}
