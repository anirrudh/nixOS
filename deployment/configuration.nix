{ config, pkgs, ... }:
let 
  fixedNixpkgs = import ../nixpkgs.nix;
  fixedHomeManager = import ../hmpkgs.nix;
  autostart_albert = (pkgs.makeAutostartItem{ name = "albert"; package = pkgs.albert; });
in
{
 
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Lara"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  #console.Font = "Lat2-Terminus16";
  #console.KeyMap = "us";

  #Enable Bluetooth
  hardware.bluetooth.enable = true; 
  
  # Enable openGL
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # lock nixpkgs
  nix.nixPath = ["nixpkgs=${fixedNixpkgs}"];
  
  # apply overlays
  nixpkgs.overlays = [ (import ../overlays/overlay.nix) ];

  # Select internationalisation properties.
  i18n = {
        defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";
  
  nixpkgs.config = {
    allowUnfree = true; 
    allowBroken = true;
  };

  # Enable home-manager
  imports = [ "${fixedHomeManager}/nixos" ];

  
  environment.systemPackages = with pkgs; [
    
    # Development
    pciutils
    neofetch
    file
    gnumake
    gcc
    cudatoolkit
    wget
    tmux
    vim
    alacritty
    (import ./emacs.nix { inherit pkgs; })

    # Themes, Icons, and Cursors
    arc-kde-theme
    latte-dock
    gnome3.adwaita-icon-theme
    papirus-icon-theme
    brave
    lutris
    slack
    hexchat
    gitter
    albert
    autostart_albert
    thunderbird
    python38
    git
    piper
    libratbag

    # Games

    # Game Drivers
    mesa
    vulkan-loader
    vulkan-headers
    vulkan-validation-layers
    vulkan-tools
    
    # Gaming Applications
    (steam.override { extraPkgs = pkgs: [ cabextract gnutls openldap winetricks ]; nativeOnly = true;})
    #steam-run
    playonlinux

    # Utilities
    gparted   
    ntfsprogs
    shutter
    etcher
    bitwarden
    discord
    unzip
  
  ];
  
   # Use NVIDIA Drivers 
  services.xserver.videoDrivers = ["nvidia"];

  systemd.services.nvidia-control-devices = {
    wantedBy = ["multi-user.target"];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  fonts.fonts = with pkgs; [
    helvetica-neue-lt-std
    anonymousPro
  ];


  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  programs.fish.enable = true;
  
  users.users.anirrudh = {
    isNormalUser = true;
    home ="/home/anirrudh";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users.anirrudh = { pkgs, ... }: {
    programs.fish.enable = true;
    programs.git = {
      enable = true;
      userName = "anirrudh";
      userEmail = "anik597@gmail.com";
    };
  };
 
  users.extraUsers.anirrudh = {
    shell = "/run/current-system/sw/bin/fish";
  };

  system.stateVersion = "19.09";
}
