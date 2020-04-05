{ pkgs, ... }:

let 
  hmpkgs = import ../../hmpkgs.nix;
in
{
  programs.home-manager = {
    enable = true;
    path = "${hmpkgs}";
  };

  imports = [
    ../profiles/communication.nix
    ../profiles/utilities.nix
  ];
  # neovim
  nixpkgs.overlays = [ (import ../../overlays/overlay.nix) ];
  home.packages = with pkgs; [
    htop
  ];

} 
