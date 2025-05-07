{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    kitty
    firefox
    wofi
    waybar
    dunst
    libnotify
    networkmanagerapplet
    swww
    brightnessctl
    kdePackages.dolphin
    pavucontrol
  ];
}
