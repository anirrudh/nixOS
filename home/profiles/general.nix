{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden # password manager
    neofetch  # pretty computer info
    alacritty # blazing fast gpu terminal emulator'
    firefox-devedition-bin   # an old reliable
    chromium  # you never know 
    virt-manager # virtualize all the things
    cava      # visualize audio. yeah, it's cool 
    vlc       # a multimedia tool for everything
    etcher
    obs-studio
    tdesktop
    element-desktop
    spotify
    clementineUnfree
  ];
}
