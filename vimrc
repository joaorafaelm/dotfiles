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

    " Fold
    Plug 'vim-scripts/Efficient-python-folding'

    " Auto Save
    Plug '907th/vim-auto-save'

    " Auto Read
    Plug 'djoshea/vim-autoread'

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

" space as tabs
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
au FileType javascript set tabstop=2|set shiftwidth=2|set expandtab

" identLine config
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
au BufReadPost,BufNewFile *.json let g:indentLine_conceallevel=0
let g:indentLine_char = '┆'
let g:indentLine_first_char = '┆'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

" show spaces
set list lcs=space:·,eol:¬

" Fold
highlight Folded ctermbg=233 ctermfg=239

" git gutter
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=108
highlight GitGutterChange ctermfg=108
highlight GitGutterDelete ctermfg=108
highlight GitGutterChangeDelete ctermfg=108
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
highlight ALEErrorSign ctermbg=NONE ctermfg=131
highlight ALEWarningSign ctermbg=NONE ctermfg=131

" line highlighting
set cursorline
highlight clear cursorline
highlight cursorlinenr ctermbg=NONE

:" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
:map <C-a> <Home>
:map <C-e> <End>
