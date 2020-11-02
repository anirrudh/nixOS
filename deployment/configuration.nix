{ config, pkgs, ... }:
let
  fixedNixpkgs = import ../nixpkgs.nix;
  fixedHomeManager = import ../hmpkgs.nix;
  myawesome = (pkgs.awesome.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        owner = "awesomeWM";
        repo = "awesome";
        rev = "7a759432d3100ff6870e0b2b427e3352bf17c7cc";
        sha256 = "0kjndz8q1cagmybsc0cdw97c9ydldahrlv140bfvl1xzhhbmx0hg";      };
      })).override { gtk3Support = true; };
in
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" "nvidiafb" ];
  boot.kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
  boot.extraModprobeConfig = "options vfio-pci ids=10de:1e07,10de:10f7,10de:1ad6,10de:1ad7,1b21:2142"; 
  boot.kernelParams = [ "amd_iommu=on" "video=efifb:off" ];
  # Enable virtualization
  virtualisation.libvirtd = {
    enable = true; 
    qemuOvmf = true;
  };

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
  hardware.bluetooth.config = {
  General  = {
    Enable= "Source,Sink,Media,Socket";};
  };

  # lock nixpkgs
  nix.nixPath = ["nixpkgs=${fixedNixpkgs}"];
  
  # apply overlays
  nixpkgs.overlays = [ (import ../overlays/overlay.nix) (import ../overlays/awesome.nix) ];

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
  console.keyMap = "us";
  console.font = "inter";

  # Set your time zone.
  time.timeZone = "America/New_York";
  
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
    plank
    audacious
    pavucontrol
    pulseaudio-modules-bt
    looking-glass-client
    papirus-icon-theme
    rofi
    protontricks
    nfs-utils
    direnv
    gnumake
    gcc
    wget
    libsecret
    tmux
    krusader
    tmuxp
    clang-tools
    gparted
    picom
    firefox-bin
    neovim
    (import ./programs/emacs.nix { inherit pkgs; })
    (python3.withPackages(ps: [
      ps.python-language-server
      ps.pyls-mypy ps.pyls-isort ps.pyls-black
    ]))
  ];
  
  # Use NVIDIA Drivers 
  services.xserver.videoDrivers = ["amdgpu"];
  #systemd.services.nvidia-control-devices = {
  #  wantedBy = ["multi-user.target"];
  #  serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  #};
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 anirrudh qemu-libvirtd -"
  ];
  # Add Custom Fonts

  fonts.fonts = with pkgs; [
    inter
    anonymousPro
    source-code-pro
    (nerdfonts.override {
      fonts = [ "DroidSansMono" ];
    })
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
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.picom = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 5;
      fadeSteps = [ 0.03 0.03 ]; # in and out
      fadeExclude = [ "name = 'Plank'"];
      inactiveOpacity = 0.85;
      shadow = true;
      shadowExclude = [ "name = 'Plank'" "_NET_WM_WINDOW_TYPE:a = '_NET_WM_WINDOW_TYPE_NOTIFICATION'" "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'" "_GTK_FRAME_EXTENTS@:c" ]; 
      vSync = true;
      wintypes = {     
        tooltip =
      {
        # fade: Fade the particular type of windows.
        fade = true;
        # shadow: Give those windows shadow
        shadow = false;
        # opacity: Default opacity for the type of windows.
        opacity = 0.85;
        # focus: Whether to always consider windows of this type focused.
        focus = true;
      };

      dock = 
      {
    	shadow = false;
      };
    };

    };

    services.bamf.enable = true;
    programs.dconf.enable = true;
    services.xserver.windowManager = {
    awesome = { 
    enable =  true; 
    luaModules = with pkgs.luaPackages; [
      luarocks
      luadbi-mysql
    ];
    package = myawesome;
  };
};
services.cron = {
    enable = true;
    systemCronJobs = [
    ];
  };

services.xserver.displayManager = {
    lightdm = { enable = true; };
    sessionCommands = ''
  ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
    Xft.dpi : 163

    !! Colorscheme

    ! special
    *.foreground:   #93a1a1
    *.background:   #002b36
    *.cursorColor:  #93a1a1

    ! black
    *.color0:       #002b36
    *.color8:       #657b83

    ! red
    *.color1:       #dc322f
    *.color9:       #dc322f

    ! green
    *.color2:       #859900
    *.color10:      #859900

    ! yellow
    *.color3:       #b58900
    *.color11:      #b58900

    ! blue
    *.color4:       #268bd2
    *.color12:      #268bd2

    ! magenta
    *.color5:       #6c71c4
    *.color13:      #6c71c4

    ! cyan
    *.color6:       #2aa198
    *.color14:      #2aa198

    ! white
    *.color7:       #93a1a1
    *.color15:      #fdf6e3

  ''}
'';
    };


    users.extraUsers.anirrudh = {
    isNormalUser = true;
    home = "/home/anirrudh";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "libvirtd" ];
  };

  system.stateVersion = "19.09";
}
