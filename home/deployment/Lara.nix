{ pkgs, ... }:

let 
  hmpkgs = import ../../hmpkgs.nix;
in
{
  programs.home-manager = {
    enable = true;
    path = "${hmpkgs}";
  };

  nixpkgs.overlays = [ (import ../../overlays/overlay.nix) ];

  home.packages = with pkgs; [
    htop
  ];

} 
