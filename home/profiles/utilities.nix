{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gparted   # frontend gui for parted
    shutter   # screenshot capture tool
    etcher    # usb burning tool
    unzip     # makes unzipping easy
    bitwarden # password manager
    neofetch  # pretty computer info
    brave     # brave browser - privacy
    firefox   # backup safe and trusty browser
  ];
}
