{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    kitty
    firefox
    thunderbird
    keepassxc
  ];
}
