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
    shellInit ="set -e SSH_ASKPASS
    alias nix-config='tmuxp load ~/dotfiles/nix_config_session.yaml'";
  };

  programs.alacritty = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "anirrudh";
    userEmail = "anik597@gmail.com";
  };

  programs.tmux = {
    enable = true;
    shortcut = "b"; # Map Leader => CTRL-B
    terminal = "screen-256color";
    baseIndex = 1;
    tmuxp.enable = true; 
    extraConfig = ''
      source ${pkgs.python38Packages.powerline}/share/tmux/powerline.conf
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind '"' split-window -h -c "#{pane_current_path}"
      bind % split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };

  programs.urxvt = {
    enable = true;
    fonts = [ "xft:Droid Sans Mono Nerd Font:size=14" ];
    keybindings = { 
      "Shift-Control-C" = "eval:selection_to_clipboard";
      "Shift-Control-V" = "eval:paste_clipboard";
    };
    scroll.bar = {
      enable = false;
    };
  };

  services.lorri.enable = true;

  imports = [
    ../profiles/communication.nix
    ../profiles/general.nix
    ../profiles/sysutils.nix
    ../profiles/development.nix
  ];

  # neovim
  nixpkgs.overlays = [ (import ../../overlays/overlay.nix) ];

  nixpkgs.config.allowUnfree = true;
} 
