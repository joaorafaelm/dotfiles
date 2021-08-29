call plug#begin('~/.vim/plugins')
    Plug 'morhetz/gruvbox'
    Plug 'airblade/vim-gitgutter'
    Plug 'w0rp/ale'
    Plug 'ruanyl/vim-gh-line'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'mgedmin/taghelper.vim'
    Plug 'codota/tabnine-vim'
    Plug 'caenrique/nvim-maximize-window-toggle'
    Plug 'vimlab/split-term.vim'
    Plug 'rmagatti/auto-session'
    Plug 'APZelos/blamer.nvim'
call plug#end()

scriptencoding utf-8
set encoding=utf-8

" default shell
set shell=$SHELL

syntax on
set number
set relativenumber
set scrolloff=10
set backspace=indent,eol,start
set nowrap
set autoindent
filetype plugin on
let mapleader = ','

" space as tabs
filetype plugin indent off
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
au FileType javascript set tabstop=4|set shiftwidth=4|set expandtab
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType make setlocal noexpandtab
set updatetime=100
set mouse=a
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard
  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Highlight search matches
set hlsearch 
" Ignore case when searching
set ignorecase
" except when search string contains uppercase
set smartcase
" Jump to first match while entering search string
set incsearch

" show spaces, eol, tabs etc
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list

"theme config
colorscheme gruvbox
let g:gruvbox_contrast_dark='medium'
set background=dark

" Inherit background color from terminal
highlight normal ctermbg=NONE

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
hi IndentGuidesOdd  ctermbg=234
hi IndentGuidesEven ctermbg=234

" line highlighting
set cursorline

"highlight clear cursorline
highlight cursorlinenr ctermbg=NONE
highlight cursorline ctermbg=235 ctermfg=NONE
highlight cursorcolumn ctermbg=235

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Fold
highlight Folded ctermbg=233 ctermfg=239
set foldmethod=indent
set foldnestmax=3
set fml=0
nnoremap <space> za
vnoremap <space> zf

" git gutter
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=108
highlight GitGutterChange ctermfg=108
highlight GitGutterDelete ctermfg=108
highlight GitGutterChangeDelete ctermfg=108

" disable preview window
set completeopt-=preview

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

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   silent! exe "normal! g`\"" |
     \   silent! exe "normal! zA`\"" |
     \ endif

" Auto reload file
set autoread

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent!
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | silent! checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

:" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
map <C-a> <Home>
map <C-e> <End>

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

"fzf
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-s> :GFiles?<CR>
nnoremap <silent> <C-r> :History:<CR>
nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg/')<CR>

function! SearchWordWithAg()
    execute 'Rg' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Rg' selection
endfunction

" Redo with U instead of Ctrl+R
noremap U <C-R>

" debugger shortcut
ab br breakpoint()<CR>
func! s:SetBreakpoint()
    let indent = strlen(matchstr(getline(line(".") - 1), '^\s*'))
    if indent == 0
        let indent = strlen(matchstr(getline(line(".")), '^\s*'))
    endif
    cal append('.', repeat(' ', indent). 'breakpoint()')
    exec ':w'
endf

func! s:RemoveBreakpoint()
    exe 'silent! g/^\s*breakpoint()/d'
endf

func! s:ToggleBreakpoint()
    if getline('.')=~#'^\s*breakpoint' | cal s:RemoveBreakpoint() | el | cal s:SetBreakpoint() | en
endf
nnoremap <leader>p :call <SID>ToggleBreakpoint()<CR>

"o/O Start insert mode with [count] blank lines.
function! s:NewLineInsertExpr( isUndoCount, command )
    if ! v:count
        return a:command
    endif

    let l:reverse = { 'o': 'O', 'O' : 'o' }
    " First insert a temporary '$' marker at the next line (which is necessary
    " to keep the indent from the current line), then insert <count> empty lines
    " in between. Finally, go back to the previously inserted temporary '$' and
    " enter insert mode by substituting this character.
    " Note: <C-\><C-n> prevents a move back into insert mode when triggered via
    " |i_CTRL-O|.
    return (a:isUndoCount && v:count ? "\<C-\>\<C-n>" : '') .
    \   a:command . "$\<Esc>m`" .
    \   v:count . l:reverse[a:command] . "\<Esc>" .
    \   'g``"_s'
endfunction
nnoremap <silent> <expr> o <SID>NewLineInsertExpr(1, 'o')
nnoremap <silent> <expr> O <SID>NewLineInsertExpr(1, 'O')

" Dont copy to clipboard deleted text
nnoremap d "_d
vnoremap d "_d

" run rg + fzf command, open file in new pane
func! s:OpenFile()
exe 'silent! !fzf_grep_edit' |
redraw!
endf
nnoremap <silent> † :call <SID>OpenFile()<CR>

" Open fzf rg on word under cursor
func! s:OpenCWord()
let word_under_cursor = expand("<cword>")
exe 'silent! !clear' |
exe 'silent! !fzf_grep_edit ' word_under_cursor |
redraw!
endf
nnoremap <silent> <C-p> :call <SID>OpenCWord()<CR>

" run test for current method
fun! RunPytest()
    let test_name = substitute(substitute(taghelper#curtag(), "\[", "", ""), "\]", "", "")
    if test_name =~ "test_"
        silent! exec '!tmux split-window -h -t $TMUX_PANE pipenv run pytest -k ' test_name
    endif
endfun
map <silent> t :call RunPytest() <CR>

" quickly exit
nnoremap <silent> ZZ :wqa!<CR>

" Auto complete menu
hi Pmenu ctermfg=15 ctermbg=236
hi PmenuSel ctermfg=233 ctermbg=108

" paste in next line
nmap p :pu<CR>

" Auto update plugins every week
function! OnVimEnter() abort
    " Run PlugUpdate every week automatically when entering Vim.
    if exists('g:plug_home')
        let l:filename = printf('%s/.vim_plug_update', g:plug_home)
        if filereadable(l:filename) == 0
            call writefile([], l:filename)
        endif
        let l:this_week = strftime('%Y_%V')
        let l:contents = readfile(l:filename)
        if index(l:contents, l:this_week) < 0
            call execute('PlugUpdate')
            call writefile([l:this_week], l:filename, 'a')
        endif
    endif
endfunction

autocmd VimEnter * call OnVimEnter()

noremap M `
set viminfo='100,f1

" persist undo
set undodir=~/.vim/undodir
set undofile

function! s:DiffWithGITCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!git diff " . fnameescape( expand("#:p") ) . "| patch -p 1 -Rs -o /dev/stdout"
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  diffthis
endfunction
com! D call s:DiffWithGITCheckedOut()

" split styling
set fillchars+=vert:\ 
hi VertSplit ctermfg=None ctermbg=None
hi StatusLineNC ctermfg=233 ctermbg=233
hi StatusLine ctermfg=234 ctermbg=245

" change cursor for mode
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
set ttimeout
set ttimeoutlen=1
set ttyfast

" reset the cursor on start
augroup myCmds
au!
autocmd FocusGained,BufEnter,VimEnter * silent !echo -ne "\e[2 q"
augroup END

nnoremap s /
set laststatus=0

nnoremap <leader>o :ToggleOnly<Enter>
tnoremap <Esc> <C-\><C-n>

"git blamer
let g:blamer_enabled = 1
