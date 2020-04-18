{ pkgs ? <nixpkgs.unstable>, ... }:

{
  home.packages = with pkgs; [
    htop      # top for the cool kids
    git       # manage the system 
    gparted   # frontend gui for parted
    shutter   # screenshot capture tool
    etcher    # usb burning tool
    unzip     # makes unzipping easy
  ];
}
