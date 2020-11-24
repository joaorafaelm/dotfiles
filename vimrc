scriptencoding utf-8
set encoding=utf-8


" Plugins section
call plug#begin('~/.vim/plugins')

    " Gruvbox theme
    Plug 'morhetz/gruvbox'

    " Git pluggin
    Plug 'airblade/vim-gitgutter'

    " Linter
    Plug 'w0rp/ale'

    " Auto complete
    Plug 'zxqfl/tabnine-vim'

    " Jump to definition
    " brew install the_silver_searcher
    Plug 'pechorin/any-jump.vim'

call plug#end()

" default shell
set shell=$SHELL

" enable pretty syntax, line numbers and bksp
syntax on
set number
set relativenumber
set scrolloff=10
set backspace=eol,start
set nowrap
filetype plugin on

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
filetype plugin indent off
set tabstop=4
set shiftwidth=4
set expandtab
au FileType javascript set tabstop=2|set shiftwidth=2|set expandtab

" show spaces
set list lcs=eol:¬

" Fold
highlight Folded ctermbg=233 ctermfg=239

" git gutter
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=108
highlight GitGutterChange ctermfg=108
highlight GitGutterDelete ctermfg=108
highlight GitGutterChangeDelete ctermfg=108

"Linters
let g:ale_enabled = 1
let b:ale_fixers = {
\   'python': ['black', 'isort', 'flake8'],
\   'javascript': ['eslint']
\}
let g:ale_fix_on_save = 0
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

" Highlight search matches
set hlsearch 
" Ignore case when searching
set ignorecase
" except when search string contains uppercase
set smartcase
" Jump to first match while entering search string
set incsearch

" Highlight word under the cursor
let g:brightest#highlight = {
\   "group" : "TabLineSel"
\}

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

"any jump
hi Pmenu guibg=#1b1b1b ctermbg=235

" debugger shortcut
ab ip import ipdb;ipdb.set_trace()
