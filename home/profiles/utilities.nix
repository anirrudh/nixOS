{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gparted   # frontend gui for parted
    shutter   # screenshot capture tool
    etcher    # usb burning tool
    unzip     # makes unzipping easy
    bitwarden # password manager
    neofetch  # pretty computer info
    brave     # privacy focused kickass browser
    alacritty # blazing fast gpu terminal emu
    firefox   # backup safe and trusty browser
    virt-manager # virtualize all the things
    cava      # visualize audio. yeah, it's cool 
    vlc       # a multimedia tool for everything
  ];
}
