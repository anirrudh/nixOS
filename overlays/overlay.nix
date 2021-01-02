self: super:  {
  neovim = super.neovim.override {
    configure = {
      customRC = ''
        syntax on                         " syntax highlighting
        filetype plugin indent on
        set number                        " set line numbers on
        set hidden                        " set hidden for remapping LanguageClient
        set foldmethod=indent   " fold based on indent
        colorscheme gruvbox               " set the colorsheme
        hi Normal guibg=NONE ctermbg=NONE " enable transparent background
        map <C-n> :NERDTreeToggle<CR>     " NerdTree Toggle

        let g:LanguageClient_serverCommands = {
        \ 'python': ['pyls'],
        \ 'c': ['clangd'],
        \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
        \ }

        let g:vim_jsx_pretty_highlight_close_tag = 1
        let g:rustfmt_autosave = 1
        let g:airline#extensions#tabline#enabled = 1

        nnoremap <F5> :call LanguageClient_contextMenu()<CR>
        nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
        nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
        nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
        nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
        nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
        nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>
      '';

       plug.plugins = with super.vimPlugins; [
         vim-airline
         vim-airline-themes
         gitgutter
         auto-pairs
         fzf-vim
         vim-nix
         vim-javascript
         yats-vim
         vim-jsx-typescript
         vim-jsx-pretty
         LanguageClient-neovim
         nerdtree
         nerdtree-git-plugin
         vim-startify
         rust-vim
         bufexplorer
         gruvbox
       ];
     };
    };
}
