{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hexchat   # irc gui client
    gitter    # where devs talk 
    slack     # normal communication
    discord   # games for days
    kbfs      # keybase filesystem
    keybase   # keybase cli
    keybase-gui # keybase gui
    thunderbird # e-mail client 
    minetime    # a newer e-mail client
  ];
}
