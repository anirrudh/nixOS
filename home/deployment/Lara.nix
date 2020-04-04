{ pkgs, ... }:

let hmpkgs = import ../../hmpkgs.nix;
in
{
  programs.home-manager = {
    enable = true;
    path = "${hmpkgs}";
  };

  home.packages = [
    pkgs.htop
    #pkgs.vim_configurable
    pkgs.firefox
  ];

   programs.firefox = {
    enable = true;
  };
}
