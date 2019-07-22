scriptencoding utf-8
set encoding=utf-8


" Plugins section
call plug#begin('~/.vim/plugins')

    " Gruvbox theme
    Plug 'morhetz/gruvbox'

    " Add indent lines
    Plug 'Yggdroot/indentLine'

    " Git pluggin
    Plug 'airblade/vim-gitgutter'

    " Linter
    Plug 'w0rp/ale'

    " Auto Save
    Plug '907th/vim-auto-save'

call plug#end()

" enable auto save
let g:auto_save = 1
let g:auto_save_silent = 1

" default shell
set shell=$SHELL

" enable pretty syntax, line numbers and bksp
syntax on
set number
set relativenumber
set backspace=indent,eol,start
set nowrap

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
autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab

" identLine config
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239

" show spaces
set list lcs=space:·,eol:¬

" git gutter
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=green
highlight GitGutterDelete ctermfg=green
highlight GitGutterChangeDelete ctermfg=green
let g:gitgutter_sign_added = '█'
let g:gitgutter_sign_modified = '█'
let g:gitgutter_sign_removed = '█'
let g:gitgutter_sign_removed_first_line = '█'
let g:gitgutter_sign_modified_removed = '█'

"Linters
let g:ale_enabled = 1
let b:ale_fixers = {
\   'python': ['black', 'isort']
\}
let g:ale_pattern_options = {
\   '\.js$': {'ale_enabled': 0}
\}
let g:ale_fix_on_save = 1
let g:ale_set_highlights = 1
let g:ale_sign_error = '█'
let g:ale_sign_warning = '█'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=red

" line highlighting
set cursorline
highlight clear cursorline
highlight cursorlinenr ctermbg=NONE

:" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
:map <C-a> <Home>
:map <C-e> <End>
