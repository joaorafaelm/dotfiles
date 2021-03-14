call plug#begin('~/.vim/plugins')
    Plug 'morhetz/gruvbox'
    Plug 'airblade/vim-gitgutter'
    Plug 'w0rp/ale'
    Plug 'ruanyl/vim-gh-line'
    Plug 'vim-test/vim-test'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'jebaum/vim-tmuxify'
call plug#end()
