{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    kitty
    firefox
  ];
}
