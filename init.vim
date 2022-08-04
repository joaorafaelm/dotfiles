set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

call plug#begin('~/.vim/plugins')
    Plug 'morhetz/gruvbox'
    Plug 'airblade/vim-gitgutter'
    Plug 'w0rp/ale'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
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
    Plug 'sindrets/winshift.nvim'
    Plug 'ruanyl/vim-gh-line'
    Plug 'joaorafaelm/vim-kata'
    function! UpdateRemotePlugins(...)
        " Needed to refresh runtime files
        let &runtimepath=&runtimepath
        UpdateRemotePlugins
    endfunction
    Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
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
set nohidden
filetype plugin on
let mapleader = ','
set winminheight=0
set winminwidth=0

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

set updatetime=50
set timeoutlen=250
set mouse=a
if has('clipboard')
    set clipboard=unnamed " copy to the system clipboard
    if has('unnamedplus') " X11 support
        set clipboard+=unnamedplus
    endif
endif

" WSL yank support
if !isdirectory('/mnt/c/Windows/')
    set clipboard+=unnamedplus
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    let g:clipboard = {
              \   'name': 'win32yank-wsl',
              \   'copy': {
              \      '+': 'win32yank.exe -i --crlf',
              \      '*': 'win32yank.exe -i --crlf',
              \    },
              \   'paste': {
              \      '+': 'win32yank.exe -o --lf',
              \      '*': 'win32yank.exe -o --lf',
              \   },
              \   'cache_enabled': 0,
              \ }
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
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

set background=dark
colorscheme gruvbox

" Inherit background color from terminal
highlight normal ctermbg=16

"theme config
" Background colors for active vs inactive windows
highlight ActiveWindow ctermbg=233
highlight InactiveWindow ctermbg=16
highlight MsgArea ctermfg=244

" Call method on window enter
augroup WindowManagement
    autocmd!
    autocmd BufWinEnter,WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
    setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
highlight IndentGuidesOdd  ctermbg=234 ctermfg=236 cterm=bold
highlight IndentGuidesEven ctermbg=234 ctermfg=236 cterm=bold

" comments
augroup CommentsGroup
    au!
    au FileType vim setlocal commentstring=\"\ %s
    au FileType python setlocal commentstring=#\ %s
    au FileType sh setlocal commentstring=#\ %s
augroup END

" line highlighting
set cursorline
" silent! set cursorlineopt=number

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

"highlight clear cursorline
highlight cursorlinenr ctermbg=NONE cterm=bold
highlight cursorline ctermbg=235
highlight Visual ctermbg=237 cterm=NONE
highlight Search cterm=inverse ctermfg=NONE
highlight cursorcolumn ctermbg=235
highlight Blamer ctermfg=240 ctermbg=NONE

" Fold
highlight Folded ctermbg=NONE ctermfg=240
highlight FoldColumn ctermbg=NONE ctermfg=235
set foldmethod=indent
set foldnestmax=3
set foldminlines=0
nnoremap <space> za
vnoremap <space> zf
nnoremap } zjzz
nnoremap { zkzz

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
    \   'javascript': ['eslint', 'prettier']
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

" quickfix
highlight link QuickFixLine CursorLine
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
function! AddToQuickFix()
    let current_win = win_getid()
    let lnum = line('.')
    let filename = expand('%:p')
    let text = trim(getline(lnum))
    let what = {
        \   'filename': filename,
        \   'lnum': lnum,
        \   'text': text,
        \   'valid': v:true,
        \ }
    call setqflist([what], 'a')
    copen
    call win_gotoid(current_win)
endfunction

" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
    let curqfidx = line('.') - 1
    let qfall = getqflist()
    call remove(qfall, curqfidx)
    call setqflist(qfall, 'r')
    execute curqfidx + 1 . 'cfirst'
    copen
endfunction
command! RemoveQFItem :call RemoveQFItem()

function! RemoveFromQuickFix()
    :silent! RemoveQFItem
    let lines = len(getqflist())
    if lines == 0
        cclose
    endif
endfunction

function! OpenQuickFix()
    copen
endfunction

function! CloseQuickFix()
    cclose
endfunction

augroup QuickFixCmds
    autocmd FileType qf map  <buffer> <silent> dd :call RemoveFromQuickFix()<cr>
    autocmd FileType qf map <buffer> <silent> <leader>q :call CloseQuickFix()<cr>
    autocmd FileType qf :resize 8
augroup END

nnoremap <silent> <leader>q :silent! :call OpenQuickFix()<cr>
nnoremap <silent> <leader>x :call AddToQuickFix()<cr>

"fzf actions
function! s:fill_quickfix(lines)
    let current_lines = getqflist()
    let selected_lines = map(copy(a:lines), '{ "filename": v:val }')
    call setqflist(selected_lines, 'a')
endfunction

let g:fzf_action = {
    \ 'ctrl-q': function('s:fill_quickfix'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-d': 'vsplit'
\ }

highlight FZFBG ctermbg=NONE ctermfg=NONE
highlight BorderFZF ctermfg=233
let g:fzf_colors = {
    \ 'bg': ['bg', 'FZFBG'],
    \ 'border': ['fg', 'BorderFZF']
\ }
let g:fzf_layout = { 'down': '~40%' }
" ctrl-p/n to navigate cmd history
let g:fzf_history_dir = '~/.fzf-history'
let $FZF_DEFAULT_OPTS='--layout=reverse-list --border --bind ctrl-a:select-all --bind ctrl-y:preview-up,ctrl-e:preview-down'
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Rg<CR><C-P>
nnoremap <silent> <C-s> :GFiles?<CR>
nnoremap <silent> <C-r> :History:<CR>
nnoremap <silent> <c-h> :Helptags<CR>
nnoremap <silent> K :call SearchWordWithRg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithRg()<CR>

function! s:fzf_statusline()
    highlight fzf1 ctermfg=233 ctermbg=233
    highlight fzf2 ctermfg=233 ctermbg=233
    highlight fzf3 ctermfg=233 ctermbg=233
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

augroup fzfGroup
    au! User FzfStatusLine call <SID>fzf_statusline()
    autocmd! FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END


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
nnoremap U <C-R>

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

" tab rename
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

" quickly exit
nnoremap <silent> ZZ :wqa!<CR>

" Auto complete menu
highlight Pmenu ctermfg=15 ctermbg=236
highlight PmenuSel ctermfg=233 ctermbg=108

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
highlight VertSplit ctermfg=None ctermbg=None
highlight StatusLineNC ctermfg=16 ctermbg=237
highlight StatusLine ctermfg=16 ctermbg=241

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

" Jump to active term window or create a new one
function SwitchToTerm()
    let term_bufs = getbufinfo({'buflisted':1})
    let curr_buf = bufnr('%')
    call filter(term_bufs, 'v:val.name =~# "^term"')
    call filter(term_bufs, 'v:val.bufnr != ' . curr_buf)
    call map(term_bufs, { _, e -> ({"nr": e.bufnr, "lu": e.lastused}) })
    if bufname('%') =~# '^term'
      call sort(term_bufs, { b1, b2 -> b1.lu - b2.lu })
    else
      call sort(term_bufs, { b1, b2 -> b2.lu - b1.lu })
    endif
    if len(term_bufs) > 0
        let window_buf_ids = win_findbuf(term_bufs[0].nr)
        call win_gotoid(win_findbuf(term_bufs[0].nr)[0])
    else
        :Term
    endif
endfunction

nnoremap <silent> <Leader>t :call SwitchToTerm()<cr>

set splitbelow
set splitright

" quit vim window on term exit
augroup terminal_settings
    autocmd!

    autocmd BufWinEnter,WinEnter,BufLeave,BufNew quickfix stopinsert
    autocmd BufWinEnter,WinEnter term://* startinsert

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
" all terminal commands
tnoremap <Esc> <C-\><C-n>
tnoremap <silent><C-f> <C-\><C-n> :Rg<CR><C-P>
tnoremap <silent><leader><space> <C-\><C-n> :Files<CR>
tnoremap <silent><C-W><up> <C-\><C-n> <C-W><up>
tnoremap <silent><C-W><down> <C-\><C-n> <C-W><down>
tnoremap <silent><C-W><left> <C-\><C-n> <C-W><left>
tnoremap <silent><C-W><right> <C-\><C-n> <C-W><right>
tnoremap <silent><C-W>z <C-\><C-n>  <C-W>\|<C-W>_
tnoremap <silent><leader>q <C-\><C-n> :silent! :call OpenQuickFix()<cr>
tnoremap <silent><leader>x <C-\><C-n> :call AddToQuickFix()<cr>
tnoremap <silent><leader>e <C-\><C-n> :WinResizerStartResize<CR>
tnoremap <silent><leader>s <C-\><C-n> :Term<CR>
tnoremap <silent><leader>d <C-\><C-n> :VTerm<CR>
tnoremap <silent><C-W>p <C-\><C-n> <C-W>p<CR>

" zoom
nnoremap <C-W>z <C-W>\|<C-W>_

" vimdiff in new tab
function! GStatusGetFilenameUnderCursor()
    return matchstr(getline('.'), '^[A-Z?] \zs.*')
endfunction

command! GdiffsplitTab call GdiffsplitTab(expand("%"))
function! GdiffsplitTab(filename)
    exe 'tabedit ' . a:filename
    Gvdiffsplit
endfunction

" custom mapping in fugitive window (:Git)
nnoremap <silent> <leader>g :G<CR>
augroup custom_fugitive_mappings
    au!
    au User FugitiveIndex map <buffer> <space> =
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
        let total = a + m * 2 + r
        " return total
        return ''
    else
        return ''
    endif
endfunction

function! GitStatusAddBars()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a || m || r
        let total = a + m
        " return repeat('+', total)
        return '+' . total
    else
        return ''
    endif
endfunction

function! GitStatusRemoveBars()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a || m || r
        " return repeat('-', r + m)
        return '-' . (r + m)
    else
        return ''
    endif
endfunction

highlight AddBardsHighlight ctermfg=green
highlight RemoveBardsHighlight ctermfg=red
highlight DiffHighlight ctermfg=246
set statusline=\ %f\ %m\%#DiffHighlight#%{GitStatusTotalDiff()}\ %#AddBardsHighlight#%{GitStatusAddBars()}%#RemoveBardsHighlight#%{GitStatusRemoveBars()}

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
nnoremap <silent> <leader>td o<CR><C-D><C-R>="# " . strftime("%d-%m-%Y")<CR><CR><Esc>
" buffer cycle
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" tab styling
highlight TabLineFill ctermfg=235 ctermbg=16
highlight TabLine ctermfg=240 ctermbg=234 cterm=NONE
highlight TabLineSel ctermfg=214 ctermbg=236 cterm=bold
highlight Title ctermfg=214 cterm=bold

" y behaves as other capital letters
nnoremap Y y$

" keep centered
nnoremap n nzzzv
nnoremap N Nzzzv

" f char highlight
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" session config
set sessionoptions+=tabpages,globals,winpos,terminal

" do not store global and local values in a session
set sessionoptions-=options,blank

" search word under cursor
nnoremap # #N
nnoremap * *N

" command line
highlight PmenuCustom cterm=bold ctermfg=red ctermbg=NONE
highlight PmenuSelCustom cterm=inverse ctermfg=108 ctermbg=233
highlight PmenuTextCustom ctermfg=245 ctermbg=233
call wilder#setup({'modes': [':']})
call wilder#set_option('use_python_remote_plugin', 0)
call wilder#set_option('renderer', wilder#wildmenu_renderer({
    \ 'highlighter': wilder#basic_highlighter(),
    \ 'highlights': {
    \   'default': wilder#make_hl('PmenuTextCustom', 'PmenuTextCustom', [{}, {}, {}]),
    \   'accent': wilder#make_hl('WilderAccent', 'PmenuCustom', [{}, {}, {}]),
    \   'selected': wilder#make_hl('WilderWildmenuSelectedAccent', 'PmenuSelCustom', [{}, {}, {}]),
    \ },
\ }))

" highlight the word under cursor (CursorMoved is inperformant)
augroup CWordHiGroup
    autocmd CursorHold * call HighlightCursorWord()
augroup END
highlight HiCursorWord ctermbg=236 cterm=inverse
function! HighlightCursorWord()
    let cword = expand('<cword>')
    exe printf('match hiCursorWord /\V\<%s\>/', escape(cword, '/\'))
endfunction

" lua scripts
lua <<EOF
    require("winshift").setup({
        highlight_moving_win = false
    })
EOF

" Start Win-Move mode:
nnoremap <C-W>m <Cmd>WinShift<CR>

" Copy github link
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '
