self: super:  {
  awesome = super.awesome.override { gtk3Support = true; }; 
  neovim = super.neovim.override {
    configure = {
      customRC = ''
        Plug 'peitalin/vim-jsx-typescript'
        syntax on                         " syntax highlighting
        set number                        " set line numbers on
        set hidden                        " set hidden for remapping LanguageClient
        colorscheme gruvbox               " set the colorsheme
        hi Normal guibg=NONE ctermbg=NONE " enable transparent background
        map <C-n> :NERDTreeToggle<CR>     " NerdTree Toggle

        let g:ycm_global_ycm_extra_conf = '~/dotfiles/home/settings/.ycm_extra_conf.py'
        let g:LanguageClient_serverCommands = {
        \ 'python': ['pyls'],
        \ 'c': ['clangd']
        \ }
        let g:vim_jsx_pretty_highlight_close_tag = 1

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
         vim-javascript
         yats-vim
         vim-jsx-pretty
         LanguageClient-neovim
         nerdtree
         nerdtree-git-plugin
         YouCompleteMe
         gruvbox
       ];
     };
    };
}
