{ config, pkgs, ... }:

{
    imports = [       
        ./hardware-configuration.nix
        ./systemPackages.nix
        ./nvidia.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 5;

    networking.hostName = "nixos"; 

    # Enable networking
    networking.networkmanager.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "plasma";
    programs.dconf.enable = true;

    # Configure keymap in X11
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    users.defaultUserShell = pkgs.zsh;

    users.users.rajwol = {
        isNormalUser = true;
        description = "Rajwol Chapagain";
        extraGroups = [ "networkmanager" "wheel" ];
        useDefaultShell = true;
        packages = with pkgs; [
        ];
    };

    fonts.packages = with pkgs; [
        fira
        roboto
        nerdfonts
    ];

    environment.sessionVariables = {
        MOZ_USE_XINPUT2 = "1";
        EDITOR = "nvim";
    };


    #=============== Programs enabled via options ===============

    programs.firefox = {
        enable = true;
        preferences = {
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "media.hardware-video-decoding.force-enabled" = true;
        };
    };

    programs.zsh = {
        enable = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        shellAliases = {
            editconf = "sudo nvim /home/rajwol/.dotfiles/configuration.nix";
            rebuild = "sudo nixos-rebuild switch --flake /home/rajwol/.dotfiles/";
            update = "sudo nix flake update /home/rajwol/.dotfiles/";
            clean = "sudo nix-collect-garbage";
            wipe = "sudo nix-collect-garbage --delete-old";
            ls = "eza --icons";
            push_pw = "rclone copy ~/Documents/Passwords.kdbx remote:Personal/";
            pull_pw = "rclone copy remote:Personal/Passwords.kdbx ~/Documents/";
        };

        promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        ohMyZsh = {
            enable = true;
        };
    };

    programs.nh = {
        enable = true;
        flake = "/home/rajwol/.dotfiles";
    };

    programs.steam = {
        enable = true;
    };

    #=============== Services ===============

    services.thermald.enable = true;
    services.flatpak.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    system.stateVersion = "23.11"; # Don't change
}
