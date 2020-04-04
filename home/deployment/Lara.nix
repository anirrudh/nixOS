{ pkgs, ... }:

let 
hmpkgs = import ../../hmpkgs.nix;
in
{

  programs.home-manager = {
    enable = true;
    path = "${hmpkgs}";
  };

  home.packages = [
    pkgs.htop
    pkgs.firefox
    pkgs.neovim
  ];

  programs.firefox = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
  };

} 
