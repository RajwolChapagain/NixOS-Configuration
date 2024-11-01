{ config, pkgs, ...}:
{
    nixpkgs.config.allowUnfree = true;
 
    environment.systemPackages = with pkgs; [
        neovim
        neofetch
        git
        bat
        thunderbird
        keepassxc
        signal-desktop
        kate
        python3
        mangohud
        gamemode
        goverlay
        zoom-us
        zoxide
        fzf
        zsh-powerlevel10k
        slack
        adwaita-icon-theme
        wl-clipboard
        kitty
        eza
        rclone
        inkscape
        (retroarch.override {
            cores = with libretro; [
              snes9x
            ];
        })
        texliveFull
        texmaker
        libreoffice-qt6
        gcc
    ];
}
