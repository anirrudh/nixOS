{ pkgs ? <nixpkgs.unstable>, ... }:

{
  home.packages = with pkgs; [
    tmux                       # the classuc workhorse
    python38Packages.powerline # powerline for tmux!
    tmuxp                      # easy tmux session management
    direnv                     # enable direnv
  ];
}
