{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hexchat   # GUI Client for IRC
    gitter    # Where Developers Talk
    discord   # Gaming with friends
    slack     # Number 2 competitor for eating RAM
    thunderbird # Communications of the yester-era
  ];
}
