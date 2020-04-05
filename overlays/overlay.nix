self: super:  {
  neovim = super.neovim.override {
    configure = {
       customRC = ''
        syntax on
        set number
      '';
      packages.myVimPackage = with super.vimPlugins; {
        start = [
          airline
          vim-nix
        ];
      };
    };
  };
}
