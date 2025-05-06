{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./system-packages.nix
      ./nvidia.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  services.xserver.videoDrivers = [ "nvidia" ];

  users.users.rajwol = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11"; # DO NOT CHANGE
}

