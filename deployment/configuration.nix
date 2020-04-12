{ config, pkgs, ... }:
let 
  fixedNixpkgs = import ../nixpkgs.nix;
  fixedHomeManager = import ../hmpkgs.nix;
  autostart_albert = (pkgs.makeAutostartItem{ name = "albert"; package = pkgs.albert; });
in
{
  # Use the systemd-boot EFI boot loader.
  boot.initrd.availableKernelModules = [
    "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-amd" ];

  # Enable virtualization
  virtualisation.libvirtd.enable = true; 
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  networking.hostName = "Lara"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;

  #Enable Bluetooth
  hardware.bluetooth.enable = true; 

  # lock nixpkgs
  nix.nixPath = ["nixpkgs=${fixedNixpkgs}"];
  
  # apply overlays
  nixpkgs.overlays = [ (import ../overlays/overlay.nix) ];

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
  console.keyMap = "us";
  console.font = "Lat2-Terminus16";

  # Set your time zone.
  time.timeZone = "America/Chicago";
  
  nixpkgs.config = {
    allowUnfree = true; 
  };

  imports = [ 
    "${fixedHomeManager}/nixos"   # Home-Manager
    ./profiles/graphics.nix       # Graphics (Vulkan, CUDA)
    ./profiles/uiux.nix           # UI/UX (Icons, Themes)
    ./profiles/gaming.nix         # Gaming Libraries (Steam, Lutris)
    ./profiles/custohware.nix     # Custom hardware (qmk, logitech)
  ];
  
  environment.systemPackages = with pkgs; [
    direnv
    pciutils
    brave
    file
    gnumake
    gcc
    wget
    libsecret
    tmux
    llvm
    neovim
    latte-dock
    (import ./programs/emacs.nix { inherit pkgs; })
    albert
    autostart_albert
    git
    etcher
    obs-studio
    vagrant
    (python3.withPackages(ps: [
      ps.python-language-server
      ps.pyls-mypy ps.pyls-isort ps.pyls-black
    ]))
  ];
  
  # Use NVIDIA Drivers 
  services.xserver.videoDrivers = ["nvidia"];
  systemd.services.nvidia-control-devices = {
    wantedBy = ["multi-user.target"];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  # Add Custom Fonts

  fonts.fonts = with pkgs; [
    anonymousPro
    source-code-pro
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
  hardware.pulseaudio.support32Bit = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  users.extraUsers.anirrudh = {
    isNormalUser = true;
    home = "/home/anirrudh";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "libvirtd" ];
  };

  system.stateVersion = "19.09";
}
