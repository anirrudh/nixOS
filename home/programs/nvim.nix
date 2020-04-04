{config, lib, pkgs, ...}:

{
  packageOverrides = pkgs: with pkgs; {
  myNeovim = pkgs.neovim.override {
  configure = {
    customRC = ''
    set number
    '';
    packages.myVimPackage = with pkgs.vimPlugins; {
      # see examples below how to use custom packages
      start = [ ];
      # If a Vim plugin has a dependency that is not explicitly listed in
      # opt that dependency will always be added to start to avoid confusion.
      opt = [ ];
    };
  };
};
};
}
