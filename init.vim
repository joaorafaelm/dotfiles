set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

call plug#begin('~/.vim/plugins')
    function! UpdateRemotePlugins(...)
        " Needed to refresh runtime files
        let &runtimepath=&runtimepath
        UpdateRemotePlugins
    endfunction
    Plug 'morhetz/gruvbox'
    Plug 'airblade/vim-gitgutter'
    Plug 'w0rp/ale'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'mgedmin/taghelper.vim'
    Plug 'vimlab/split-term.vim'
    Plug 'APZelos/blamer.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'jkramer/vim-checkbox'
    Plug 'simeji/winresizer'
    Plug 'tpope/vim-commentary'
    Plug 'gcmt/taboo.vim'
    Plug 'sindrets/winshift.nvim', {'branch': 'main'}
    Plug 'ruanyl/vim-gh-line'
    Plug 'hashivim/vim-terraform'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'github/copilot.vim'
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'chomosuke/term-edit.nvim', {'tag': 'v1.*'}
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'vim-scripts/argtextobj.vim'
    Plug 'mbbill/undotree'
    Plug 'aduros/ai.vim'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
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
set wrap
set autoindent
set nohidden
filetype plugin on
let mapleader = ','
set winminheight=0
set winminwidth=0
" set iskeyword-=_

" space as tabs
filetype plugin indent off

set tabstop=4
set shiftwidth=4
set expandtab

augroup file_format
    au!
    au FileType javascript set tabstop=2|set shiftwidth=2|set expandtab
    au FileType jsx set tabstop=2|set shiftwidth=2|set expandtab
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

let g:loaded_python3_provider = 0

" Background and foreground colors
hi normal ctermbg=16 ctermfg=247

" Background colors for active vs inactive windows
hi ActiveWindow ctermbg=233
hi InactiveWindow ctermbg=16
hi MsgArea ctermfg=239

"invisible characters
hi Whitespace ctermbg=NONE ctermfg=234 cterm=bold
hi Nontext ctermbg=NONE ctermfg=234 cterm=bold
hi Specialkey ctermbg=NONE ctermfg=234 cterm=bold
hi Comment cterm=italic ctermfg=239

"highlight clear cursorline
hi cursorlinenr ctermbg=NONE cterm=bold
hi cursorline ctermbg=235
hi Visual ctermbg=237 cterm=NONE
hi Search cterm=inverse ctermfg=NONE
hi cursorcolumn ctermbg=235
hi Blamer ctermfg=239 ctermbg=NONE cterm=italic
hi LineNr ctermfg=234 cterm=bold
hi HiCursorWord ctermbg=236

" Fold
hi Folded ctermbg=NONE ctermfg=239
hi FoldColumn ctermbg=NONE ctermfg=235

" Git gutter and vimdiff
hi clear SignColumn
hi GitGutterAdd ctermfg=108
hi GitGutterChange ctermfg=108
hi GitGutterDelete ctermfg=131
hi GitGutterChangeDelete ctermfg=108
hi ALEErrorSign ctermbg=NONE ctermfg=131
hi ALEWarningSign ctermbg=NONE ctermfg=131

" Quickfix
hi link QuickFixLine CursorLine

" FZF colors
hi FZFBG ctermbg=NONE ctermfg=NONE
hi BorderFZF ctermfg=233
hi TextFZF ctermfg=245
hi fzf1 ctermfg=233 ctermbg=233
hi fzf2 ctermfg=233 ctermbg=233
hi fzf3 ctermfg=233 ctermbg=233

" Auto complete menu
hi Pmenu ctermfg=15 ctermbg=236
hi PmenuSel ctermfg=233 ctermbg=108

" Windows split
hi VertSplit ctermfg=None ctermbg=None
hi StatusLineNC ctermfg=16 ctermbg=237
hi StatusLine ctermfg=16 ctermbg=241

" Status line components
hi AddBardsHighlight ctermfg=106
hi RemoveBardsHighlight ctermfg=131
hi DiffHighlight ctermfg=246
hi FileName ctermfg=236 cterm=none
hi CurrentMode ctermfg=236 cterm=bold

" tab styling
hi TabLineFill ctermfg=235 ctermbg=16
hi TabLine ctermfg=240 ctermbg=234 cterm=NONE
hi TabLineSel ctermfg=214 ctermbg=236 cterm=bold
hi Title ctermfg=214 cterm=bold

" command line
hi PmenuCustom cterm=bold ctermfg=red ctermbg=NONE
hi PmenuSelCustom ctermbg=233
hi PmenuTextCustom ctermfg=240 ctermbg=16

" ai.vim
hi link AIHighlight Visual

if &background ==# 'light'
    " Background and foreground colors
    hi normal ctermbg=254 ctermfg=0

    " Background colors for active vs inactive windows
    hi ActiveWindow ctermbg=254
    hi InactiveWindow ctermbg=251

endif

" Call method on window enter
augroup WindowManagement
    autocmd!
    autocmd BufWinEnter,WinEnter * call Handle_Win_Enter()
augroup END

" new tab shortcut
map <C-t> :tabe term://zsh<CR>

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
    setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction

" comments
augroup CommentsGroup
    au!
    au FileType vim setlocal commentstring=\"\ %s
    au FileType python setlocal commentstring=#\ %s
    au FileType sh setlocal commentstring=#\ %s
    au FileType awk setlocal commentstring=#\ %s
augroup END

" line highlighting
set cursorline
silent! set cursorlineopt=number

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

"fold stuff
set foldmethod=indent
set foldnestmax=3
set foldminlines=0
set foldlevel=99
nnoremap <space> za
vnoremap <space> zf
nnoremap } zjzz
nnoremap { zkzz

" git gutter
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_first_line = '│'
let g:gitgutter_sign_removed_above_and_below = '│'
let g:gitgutter_sign_modified_removed = '│'

" disable preview window
set completeopt-=preview

"Linters
let g:ale_enabled = 1
let b:ale_fixers = {
    \   'python': ['black', 'isort', 'flake8'],
    \   'javascript': ['eslint', 'prettier']
    \}
let g:ale_fix_on_save = 1
let g:ale_set_highlights = 1
let g:ale_sign_error = '█'
let g:ale_sign_warning = '█'

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
augroup END

" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
inoremap <C-a> <Home>
inoremap <C-e> <End>
nnoremap <C-a> <Home>
nnoremap <C-e> <End>

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :let @/ = ""<CR><CR>

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
map <C-j> :diffoff<CR>:q<CR>:cn<CR>:Gdiffsplit<CR>
map <C-k> :diffoff<CR>:q<CR>:cp<CR>:Gdiffsplit<CR>

"fzf actions
" Jump to open buffer
let g:fzf_buffers_jump = 1

let g:prosession_dir = '~/.local/share/nvim/sessions/'
let g:prosession_on_startup = 1

function! s:list_sessions() abort
    return systemlist('ls -t ' . g:prosession_dir . ' | grep -v last_session | sed "s/%/\//g"')
endfunction

" swap edit:
" if a swap file exists, open it in a new buffer
augroup SwapEditOption
    autocmd SwapExists * let v:swapchoice = 'e'
augroup END


let g:fzf_current_session = ''
function! s:source_session(lines) abort
    let key = a:lines[0]
    let file = a:lines[1]
    let file = g:prosession_dir . substitute(file, '/', '\\%', 'g')
    if key ==# 'ctrl-x'
        silent! exec '!rm ' . file
        :SessionPicker
    else
        silent! exec 'source ' . file
    endif
endfunction

command! SessionPicker call fzf#run(fzf#wrap({
  \ 'source': s:list_sessions(),
  \ 'sink*': { lines -> s:source_session(lines) },
  \ 'options': '--expect=ctrl-x'
  \ }))


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


let g:fzf_colors = { 
    \ 'fg':      ['fg', 'TextFZF'],
    \ 'bg':      ['bg', 'FZFBG'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'BorderFZF'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] 
\ }

let g:fzf_layout = { 'down': '~40%' }

" ctrl-e/y to navigate cmd history
let g:fzf_history_dir = '~/.fzf-history'
let $FZF_DEFAULT_OPTS = '--inline-info --layout=reverse-list --border=vertical'
let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . ' --bind ctrl-a:select-all --bind ctrl-y:preview-up,ctrl-e:preview-down'
let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . ' --preview-window noborder --margin 0 --padding 0 --no-separator'
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Rg<CR><C-P>
nnoremap <silent> <C-s> :GFiles?<CR>
nnoremap <silent> <C-r> :History:<CR>
nnoremap <silent> <c-h> :Helptags<CR>
nnoremap <silent> K :call SearchWordWithRg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithRg()<CR>
nnoremap <c-\> :SessionPicker<cr>

function! s:fzf_statusline()
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

augroup fzfGroup
    au! User FzfStatusLine call <SID>fzf_statusline()
    autocmd! FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
      \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
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
set fillchars+=fold:\ 

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

" git blamer
let g:blamer_enabled = 1

" terminal binding
nnoremap <silent> <leader>s :Term<CR>
nnoremap <silent> <leader>d :VTerm<CR>

" Jump to active term window or create a new one
function SwitchToTerm()
  try
    let term_bufs = filter(getbufinfo({'buflisted':1}), 'v:val.name =~# "^term"')
    let curr_buf = bufnr('%') - 1
    let term_bufs = filter(term_bufs, 'v:val.bufnr != ' . curr_buf)
    let term_bufs = map(term_bufs, { _, e -> ({"nr": e.bufnr, "lu": e.lastused}) })
    let term_bufs = sort(term_bufs, { b1, b2 -> b2.lu - b1.lu })
    if len(term_bufs) > 0 && win_gotoid(win_findbuf(term_bufs[0].nr)[0])
      return
    endif 
  catch
  endtry
  :Term
endfunction


nnoremap <silent> <Leader>t :call SwitchToTerm()<cr>

map <C-Up> <C-W>k
map <C-Down> <C-W>j
map <C-Left> <C-W>h
map <C-Right> <C-W>l
set splitbelow
set splitright

" quit vim window on term exit
augroup terminal_settings
    autocmd!

    autocmd BufWinEnter,WinEnter,BufLeave,BufNew quickfix stopinsert
    autocmd BufWinEnter,WinEnter term://* stopinsert
    " Ignore various filetypes as those will close terminal automatically
    " Ignore fzf, ranger, coc
    autocmd TermClose term://*
          \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
          \   call nvim_input('<CR>')  |
          \ endif
augroup END

" disable split term default mappins
let g:disable_key_mappings = 1

" zoom
let s:zoomed_in = 0
function! ToogleZoom()
    if s:zoomed_in
        :exe "normal \<C-W>="
        let s:zoomed_in = 0
    else
        :exe "normal \<C-W>\|\<C-W>_"
        let s:zoomed_in = 1
    endif
endfunction
nnoremap <leader>z :call ToogleZoom()<CR>

" hit esc twice to exit term mode
" all terminal commands
tnoremap <Esc> <C-\><C-n>
tnoremap <silent><C-f> <C-\><C-n>:Rg<CR><C-P>
tnoremap <silent><leader>q <C-\><C-n>:silent! :call OpenQuickFix()<cr>
tnoremap <silent><leader>x <C-\><C-n>:call AddToQuickFix()<cr>
tnoremap <silent><leader>e <C-\><C-n>:WinResizerStartResize<CR>
tnoremap <silent><leader>s <C-\><C-n>:Term<CR>
tnoremap <silent><leader>z <C-\><C-n><C-W>\|<C-W>_
tnoremap <silent><leader>d <C-\><C-n>:VTerm<CR>
tnoremap <silent><leader>v <C-X><C-E><CR>
tnoremap <C-Up> <C-\><C-n><C-W>k
tnoremap <C-Down> <C-\><C-n><C-W>j
tnoremap <C-Left> <C-\><C-n><C-W>h
tnoremap <C-Right> <C-\><C-n><C-W>l


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
nnoremap <silent> <leader>g :tab G<CR>
nnoremap <silent> <leader>h :tabedit %<CR>:0Gclog<CR>:Gdiffsplit<CR>
augroup custom_fugitive_mappings
    au!
    au User FugitiveIndex map <buffer> <space> =
    au User FugitiveIndex nnoremap <buffer> dt :call GdiffsplitTab(GStatusGetFilenameUnderCursor())<CR>
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

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

function! ModeCurrent() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block'))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction


set laststatus=2
set noshowcmd
set noshowmode

set statusline=
set statusline+=%#CurrentMode#\ %{ModeCurrent()}\ %* 
set statusline+=%#FileName#%f
set statusline+=%#DiffHighlight#%{GitStatusTotalDiff()}\ %#AddBardsHighlight#%{GitStatusAddBars()}%#RemoveBardsHighlight#%{GitStatusRemoveBars()}
set statusline+=%= " Right Side

" markdown fold
function! MarkdownLevel()
    let l:line = getline(v:lnum)
    if l:line =~? '^# .*$'
        return '>1' 
    elseif l:line =~? '^## .*$'
        return '>2' 
    elseif l:line =~? '^### .*$'
        return '>3' 
    elseif l:line =~? '^#### .*$'
        return '>4' 
    elseif l:line =~? '^##### .*$'
        return '>5' 
    elseif l:line =~? '^###### .*$'
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


" y behaves as other capital letters
nnoremap Y y$

" keep centered
nnoremap n nzzzv
nnoremap N Nzzzv

" session config
set sessionoptions+=tabpages,globals,winpos,terminal

" do not store global and local values in a session
set sessionoptions-=options,blank

" search word under cursor
nnoremap # #N
nnoremap * *N

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

function! HighlightCursorWord()
    let cword = expand('<cword>')
    exe printf('match hiCursorWord /\V\<%s\>/', escape(cword, '/\'))
endfunction

" Copy github link
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

" vim coc
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" auto complete size
set pumheight=10

map <leader>n :sp ~/Library/Mobile Documents/com~apple~CloudDocs/notes/<CR>
let g:netrw_banner = 0
let g:netrw_altv=1

" vim copilot config
inoremap ‘ <Cmd>call copilot#Next()<CR>
inoremap “ <Cmd>call copilot#Previous()<CR>
inoremap « <Cmd>call copilot#Suggest()<CR>
let g:copilot_filetypes = {
    \ 'markdown': v:true,
    \ 'terraform': v:true,
    \ 'tf': v:true,
\ }

" window shift
nnoremap <C-W>m <Cmd>WinShift<CR>

" debug vim script
function! Decho(str)
    call writefile([a:str . "\n"], '/tmp/vim_debug.log', 'a')
endfunction

" select terminal commands output
function! SelectCommand(char) range
    if a:char ==# 'up'
        let end_command = search('^;', 'b') - 3
        let start_command = search('^;', 'bn') +  1
    else
        let start_command = search('^;') +  1
        let end_command = search('^;', 'n') - 3
    endif
    if start_command <= end_command
        execute 'normal!' start_command . 'GV' . end_command . 'G'
    endif
endfunction

nnoremap <silent> <S-UP> :call SelectCommand('up')<CR>
nnoremap <silent> <S-DOWN> :call SelectCommand('down')<CR>
vnoremap <silent> <S-UP> :call SelectCommand('up')<CR>
vnoremap <silent> <S-DOWN> :call SelectCommand('down')<CR>
tnoremap <silent> <S-UP> <C-\><C-n>:call SelectCommand('up')<CR>
tnoremap <silent> <S-DOWN> <C-\><C-n>:call SelectCommand('down')<CR>

" openai
let g:ai_no_mappings = 1
let g:ai_context_before = 20
let g:ai_context_after = 20
nnoremap <silent> <leader>f :AI<space>
inoremap <silent> <leader>f <esc>:AI<CR>
vnoremap <silent> <leader>f :AI<space>

" comments
nmap <C-_> <Plug>CommentaryLine

" vim multiline
let g:VM_default_mappings = 0


function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent! execute 'bwipeout' buf
    endfor
endfunction

augroup DeleteHiddenBuffers
    autocmd!
    autocmd BufWinLeave * silent call DeleteHiddenBuffers()
augroup END

" lua scripts
lua << EOF
    require "term-edit".setup { prompt_end = '%$ ' }
    xpcall(function()
        require "winshift".setup { highlight_moving_win = false }
    end, function(err)
    end)
EOF
