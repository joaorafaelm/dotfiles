scriptencoding utf-8
set encoding=utf-8

" Plugins section
call plug#begin('~/.vim/plugins')

    " Gruvbox theme
    Plug 'morhetz/gruvbox'
    
    " Async syntax check framework
    Plug 'maralla/validator.vim'
  
    " Add indent lines
    Plug 'Yggdroot/indentLine'

    " Git pluggin
    Plug 'airblade/vim-gitgutter'

call plug#end()


" default shell
set shell=$SHELL


" enable pretty syntax, line numbers and bksp
syntax on
set number
set relativenumber
set backspace=indent,eol,start
set nowrap
setlocal foldmethod=indent

if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

"theme config
colorscheme gruvbox
let g:gruvbox_contrast_dark='medium'
set background=dark


" Inherit background color from terminal
highlight normal ctermbg=NONE


"folding settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
let javaScript_fold=1    " Javascript
let perl_fold=1          " Perl
let php_folding=1        " PHP
let r_syntax_folding=1   " R
let ruby_fold=1          " Ruby
let sh_fold_enabled=1    " sh
let vimyn_folding='af'   " Vim script
let xml_syntax_folding=1 " XML


" space as tabs
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab


" identLine config
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '|'


" show spaces
set list lcs=space:·,eol:¬


" git gutter
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow


" line highlighting
set cursorline
highlight clear cursorline
highlight cursorlinenr ctermbg=NONE


" validator conf
let g:validator_python_checkers = ['flake8']

