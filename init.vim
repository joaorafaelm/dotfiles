set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

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
    Plug 'vimlab/split-term.vim'
    Plug 'rmagatti/auto-session'
    Plug 'APZelos/blamer.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'jkramer/vim-checkbox'
    Plug 'simeji/winresizer'
    Plug 'tpope/vim-commentary'
    Plug 'gcmt/taboo.vim'
    Plug 'unblevable/quick-scope'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

set encoding=utf-8
scriptencoding utf-8

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
set winminheight=0

" space as tabs
filetype plugin indent off
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
augroup file_format
    au!
    au FileType javascript set tabstop=4|set shiftwidth=4|set expandtab
    au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    au FileType make setlocal noexpandtab
augroup END

set updatetime=100
set mouse=a
if has('clipboard')
    set clipboard=unnamed " copy to the system clipboard
    if has('unnamedplus') " X11 support
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
let g:gruvbox_contrast_dark='hard'
set background=dark

" Inherit background color from terminal
highlight normal ctermbg=232

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
hi IndentGuidesOdd  ctermbg=234
hi IndentGuidesEven ctermbg=234

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" comments
augroup CommentsGroup
    au!
    au FileType vim setlocal commentstring=\"\ %s
    au FileType python setlocal commentstring=#\ %s
augroup END

" line highlighting
set cursorline

"highlight clear cursorline
highlight cursorlinenr ctermbg=NONE cterm=bold
highlight cursorline ctermbg=235
highlight cursorcolumn ctermbg=235
highlight Blamer ctermfg=240 ctermbg=NONE


" Fold
highlight Folded ctermbg=NONE ctermfg=236
set foldmethod=indent
set foldnestmax=3
set foldminlines=1
nnoremap <space> za
vnoremap <space> zf

" git gutter
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=108
highlight GitGutterChange ctermfg=108
highlight GitGutterDelete ctermfg=red
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

augroup file_reload
    au!
    " Return to last edit position when opening files
    au BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   silent! exe "normal! g`\"" |
         \   silent! exe "normal! zA`\"" |
         \ endif

    " Auto reload file
    set autoread

    " Triger `autoread` when files changes on disk
    " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    au FocusGained,BufEnter,CursorHold,CursorHoldI * silent!
                \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | silent! checktime | endif

    " Notification after file change
    " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    au FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
inoremap <C-a> <Home>
inoremap <C-e> <End>
nnoremap <C-a> <Home>
nnoremap <C-e> <End>

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :let @/ = ""<CR><CR>

"fzf
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-d': 'vsplit'
\ }

hi FZFBG ctermbg=NONE ctermfg=NONE
hi BorderFZF ctermfg=233
let g:fzf_colors = {
    \ 'bg': ['bg', 'FZFBG'],
    \ 'border': ['fg', 'BorderFZF']
\ }
let g:fzf_layout = { 'down': '~40%' }
let $FZF_DEFAULT_OPTS='--layout=reverse-list --border'
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-s> :GFiles?<CR>
nnoremap <silent> <C-r> :History:<CR>
nnoremap <silent> K :call SearchWordWithRg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithRg()<CR>

" window resize
nnoremap <silent> <leader>e :WinResizerStartResize<CR>
let g:winresizer_start_key	= '<leader>e'

function! SearchWordWithRg()
    execute 'Rg' expand('<cword>')
endfunction

function! SearchVisualSelectionWithRg() range
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
    let indent = strlen(matchstr(getline(line('.') - 1), '^\s*'))
    if indent == 0
        let indent = strlen(matchstr(getline(line('.')), '^\s*'))
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

" tab rename
set sessionoptions+=tabpages,globals
set guioptions-=e
let g:taboo_renamed_tab_format = ' %N:%l%m '
let g:taboo_tab_format = ' %N:%f%m '
let g:taboo_modified_tab_flag = ' ~ '

nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt
nnoremap <c-w>n :TabooRename 

" Dont copy to clipboard deleted text
nnoremap d "_d
vnoremap d "_d

" auto open fold when jumping to line
cmap <silent> <expr> <CR> getcmdtype() == ':' && getcmdline() =~ '^\d\+$' ? 'normal! zv<CR>' : '<CR>'

" run test for current method
fun! RunPytest()
    let test_name = substitute(substitute(taghelper#curtag(), '\[', '', ''), '\]', '', '')
    if test_name =~? 'test_'
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

augroup update_plug
    au!
    au VimEnter * call OnVimEnter()
augroup END

noremap M `
set viminfo='100,f1

" persist undo
set undodir=~/.vim/undodir
set undofile

" split styling
set fillchars+=vert:\ 
hi VertSplit ctermfg=None ctermbg=None
hi StatusLineNC ctermfg=232 ctermbg=237
hi StatusLine ctermfg=232 ctermbg=241

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
set laststatus=2

" git blamer
let g:blamer_enabled = 1

" terminal binding
nnoremap <silent> <leader>s :Term<CR>
nnoremap <silent> <leader>d :VTerm<CR>

" quit vim window on term exit
augroup terminal_settings
autocmd!

autocmd BufWinEnter,WinEnter,BufLeave,BufNew term://* stopinsert

" Ignore various filetypes as those will close terminal automatically
" Ignore fzf, ranger, coc
autocmd TermClose term://*
      \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
      \   call nvim_input('<CR>')  |
      \ endif
augroup END

" disable split term default mappins
let g:disable_key_mappings = 1

" hit esc twice to exit term mode
tnoremap <Esc> <C-\><C-n>

" zoom
nnoremap <C-W>z <C-W>\|<C-W>_

" vimdiff in new tab
function! GStatusGetFilenameUnderCursor()
    return matchstr(getline('.'), '^[A-Z?] \zs.*')
endfunction

command! GdiffsplitTab call GdiffsplitTab(expand("%"))
function! GdiffsplitTab(filename)
    exe 'tabedit ' . a:filename
    Gdiffsplit
endfunction

" custom mapping in fugitive window (:Git)
nnoremap <silent> <leader>g :tab G<CR>
augroup custom_fugitive_mappings
    au!
    au User FugitiveIndex nnoremap <buffer> dt :call GdiffsplitTab(GStatusGetFilenameUnderCursor())<cr>
augroup END

" Git status
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a || m || r
        echo a + m
        return printf('+%d ~%d -%d', a, m, r)
    else
        return ''
    endif
endfunction

function! GitStatusTotalDiff()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a || m || r
        let total = a + m + r
        return total
    else
        return ''
    endif
endfunction

function! GitStatusAddBars()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a || m || r
        let total = a + m
        return repeat('+', total)
    else
        return ''
    endif
endfunction

function! GitStatusRemoveBars()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a || m || r
        return repeat('-', r)
    else
        return ''
    endif
endfunction

hi AddBardsHighlight ctermfg=green
hi RemoveBardsHighlight ctermfg=red
hi DiffHighlight ctermfg=246
set statusline=%F\ %#DiffHighlight#%{GitStatusTotalDiff()}\ %#AddBardsHighlight#%{GitStatusAddBars()}%#RemoveBardsHighlight#%{GitStatusRemoveBars()}

" lua scripts
lua <<EOF
EOF

" Background colors for active vs inactive windows
hi ActiveWindow ctermbg=233
hi InactiveWindow ctermbg=232

" Call method on window enter
augroup WindowManagement
    autocmd!
    autocmd BufWinEnter,WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
    setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction

" markdown fold
function! MarkdownLevel()
    if getline(v:lnum) =~? '^# .*$'
        return '>1'
    endif
    if getline(v:lnum) =~? '^## .*$'
        return '>2'
    endif
    if getline(v:lnum) =~? '^### .*$'
        return '>3'
    endif
    if getline(v:lnum) =~? '^#### .*$'
        return '>4'
    endif
    if getline(v:lnum) =~? '^##### .*$'
        return '>5'
    endif
    if getline(v:lnum) =~? '^###### .*$'
        return '>6'
    endif
    return '='
endfunction

augroup fold_formats
    au!
    au BufEnter *.md setlocal foldexpr=MarkdownLevel()
    au BufEnter *.md setlocal foldmethod=expr
augroup END

" print current date
nnoremap <silent> <leader>dt o<CR><C-D><C-R>="# " . strftime("%d-%m-%Y")<CR><CR><Esc>

" buffer cycle
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" tab styling
hi TabLineFill ctermfg=235 ctermbg=234
hi TabLine ctermfg=240 ctermbg=234 cterm=NONE
hi TabLineSel ctermfg=214 ctermbg=236 cterm=bold
hi Title ctermfg=214 cterm=bold

" y behaves as other capital letters
nnoremap Y y$

" keep centered
nnoremap n nzzzv
nnoremap N Nzzzv

" move lines
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" f char highlight
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" session config
set sessionoptions-=options    " do not store global and local values in a session

" search word under cursor
nnoremap # #N
nnoremap * *N
