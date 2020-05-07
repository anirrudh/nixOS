{config, lib, pkgs, ...}:

{
  # Allow a broken steam installation, ignore it. It works.
#  nixpkgs.config.allowBroken = true;
  nixpkgs.config.pulseaudio = true;
  environment.systemPackages = with pkgs; [
    lutris # open gaming
#    (steam.override { 
#    extraPkgs = pkgs: [ 
#      cabextract
#      gnutls
#      openldap
#      winetricks
#    ];
#    nativeOnly = true;
#  })
    steam
    playonlinux
  ];
}

