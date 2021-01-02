{ config, pkgs , ... }:
let 
    global-python = pkgs.python38.withPackages (ps: with ps; [
    pandas
    numpy
    jedi
  ]);
  powerlevel_10k_cache="'\${XDG_CACHE_HOME:-$HOME/.cache}'";
  powerlevel_10k_cache_name = "'\${(%):-%n}'";
  in
{
  # Apply Overlays
  nixpkgs.overlays = [ (import ~/nixOS/overlays/overlay.nix) (import ~/nixOS/overlays/powerline.nix) ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    [ 
      htop
      neovim
      emacs
      rustc
      todo-txt-cli
      rustfmt
      global-python 
      tmuxp
      oh-my-zsh
      zsh-powerlevel10k
      powerline
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/nixOS/deployment/Apollo.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;

  # zsh
    programs.zsh =  {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    interactiveShellInit = 
    ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
    if [[ -r "${powerlevel_10k_cache}/p10k-instant-prompt-${powerlevel_10k_cache_name}.zsh" ]]; then
    source "${powerlevel_10k_cache_name}/p10k-instant-prompt-${powerlevel_10k_cache_name}.zsh"
    fi
    source $ZSH/oh-my-zsh.sh
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme;
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh;
      alias vim="nvim"
      alias t="todo.sh"
      '';
    
      };

  # Tmux things
  programs.tmux = {
    enable = true;
    extraConfig = ''
      source ${pkgs.powerline}/share/tmux/powerline.conf
      set -g default-terminal screen-256color
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind '"' split-window -h -c "#{pane_current_path}"
      bind % split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      run-shell ${pkgs.tmuxPlugins.resurrect}
      run-shell ${pkgs.tmuxPlugins.continuum}
      run-shell ${pkgs.tmuxPlugins.vim-tmux-navigator}

    '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 12;
  nix.buildCores = 12;
}
