self: super:  {
  neovim = super.neovim.override {
    configure = {
       customRC = ''
        syntax on                         " syntax highlighting
        set number                        " set line numbers on
        set hidden                        " set hidden for remapping LanguageClient
        colorscheme gruvbox               " set the colorsheme
        hi Normal guibg=NONE ctermbg=NONE " enable transparent background
        map <C-n> :NERDTreeToggle<CR>     " NerdTree Toggle

        let g:LanguageClient_serverCommands = {
        \ 'python': ['pyls']
        \ }

        nnoremap <F5> :call LanguageClient_contextMenu()<CR>
        nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
        nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
        nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
        nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
        nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
        nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>
      '';
       plug.plugins = with super.vimPlugins; [
         lightline-vim
         gitgutter
         fzf-vim
         vim-nix
         LanguageClient-neovim
         nerdtree
         nerdtree-git-plugin
         YouCompleteMe
         gruvbox
       ];
     };
    };
}
