{ config, pkgs, ...}:
{
    nixpkgs.config.allowUnfree = true;
 
    environment.systemPackages = with pkgs; [
        neovim
        git
        bat
        thunderbird
        keepassxc
        signal-desktop
        python3
        mangohud
        gamemode
        goverlay
        zoom-us
        zoxide
        zsh-powerlevel10k
        slack
        adwaita-icon-theme
        wl-clipboard
        kitty
        eza
        rclone
        inkscape
        (retroarch.withCores (cores: with cores; [
              snes9x
        ]))
        libreoffice-qt6
        gcc
        godot_4
        krita
        mpg123
        github-desktop
        vscode.fhs
    ];
}
