{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden # password manager
    neofetch  # pretty computer info
    alacritty # blazing fast gpu terminal emulator'
    firefox-bin   # an old reliable
    chromium  # you never know 
    virt-manager # virtualize all the things
    cava      # visualize audio. yeah, it's cool 
    vlc       # a multimedia tool for everything
    kanboard
    etcher
    obs-studio
  ];
}
