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

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.xserver.videoDrivers = [ "nvidia" ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.power-profiles-daemon.enable = true;

  users.users.rajwol = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11"; # DO NOT CHANGE
}

