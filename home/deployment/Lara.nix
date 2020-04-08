{ pkgs, ... }:

let 
  hmpkgs = import ../../hmpkgs.nix;
in
{
  programs.home-manager = {
    enable = true;
    path = "${hmpkgs}";
  };

  programs.fish = { 
    enable = true;
    shellInit ="set -e SSH_ASKPASS";
  };

  programs.alacritty = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "anirrudh";
    userEmail = "anik597@gmail.com";
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
