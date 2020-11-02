{ pkgs ? <nixpkgs.unstable>, ... }:

{
  home.packages = with pkgs; [
    python38Packages.powerline # powerline for tmux!
    direnv                     # enable direnv
    dbeaver
  ];
}
