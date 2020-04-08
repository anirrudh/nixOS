{ pkgs, ... }:

let 
  hmpkgs = import ../../hmpkgs.nix;
in
{
  programs.home-manager = {
    enable = true;
    path = "${hmpkgs}";
  };

  programs.fish.enable = true;

  programs.alacritty = {
    enable = true;
  };

  imports = [
    ../profiles/communication.nix
    ../profiles/utilities.nix
  ];
  # neovim
  nixpkgs.overlays = [ (import ../../overlays/overlay.nix) ];
  home.packages = with pkgs; [
    htop
    direnv
  ];

  nixpkgs.config.allowUnfree = true;
} 
