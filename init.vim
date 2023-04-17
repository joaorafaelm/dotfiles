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
    Plug 'folke/which-key.nvim'
    Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

let g:loaded_python3_provider = 0
let mapleader = ','
set encoding=utf-8
scriptencoding utf-8
syntax on
filetype plugin on
filetype plugin indent off " space as tabs

" theme
set background=dark
colorscheme gruvbox

" Background and foreground colors
hi normal ctermbg=16 ctermfg=247

" Background colors for active vs inactive windows
hi ActiveWindow ctermbg=233
hi InactiveWindow ctermbg=16
hi MsgArea ctermfg=239
hi WinSeparator ctermfg=16 ctermbg=16

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

" which key
hi WhichKeyFloat ctermbg=16 ctermfg=239 
hi WhichKeyDesc	ctermfg=239
hi WhichKey	ctermfg=red

if &background ==# 'light'
    " Background and foreground colors
    hi normal ctermbg=254 ctermfg=0

    " Background colors for active vs inactive windows
    hi ActiveWindow ctermbg=254
    hi InactiveWindow ctermbg=251
endif

" options
set shell=$SHELL 
set number
set relativenumber
set scrolloff=10
set backspace=indent,eol,start
set wrap
set autoindent
set nohidden
set winminheight=0
set winminwidth=0
set numberwidth=6
set signcolumn=yes
set updatetime=50
set timeout
set ttimeout
set timeoutlen=250
set mouse=a
set viminfo='100,f1

" session config
set sessionoptions+=tabpages,globals,winpos,terminal

" do not store global and local values in a session
set sessionoptions-=options,blank

" default tabs length
set tabstop=4
set shiftwidth=4
set expandtab

set hlsearch " Highlight search matches
set ignorecase " Ignore case when searching
set smartcase " except when search string contains uppercase
set incsearch "Jump to first match while entering search string

" show spaces, eol, tabs etc
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list

set cursorline
set cursorlineopt=number

" status column
" let &stc='%s %#NonText#%{v:relnum} %=%#LineNr#%{v:lnum} '

"fold stuff
set foldnestmax=3
set foldminlines=0
set foldlevel=99
set foldmethod=indent
set foldcolumn=0

" disable preview window
set completeopt-=preview

" persist undo
set undodir=~/.vim/undodir
set undofile

" split styling
set fillchars+=vert:\ 
set fillchars+=fold:\ 
set splitbelow
set splitright

" statusline
set laststatus=2
set cmdheight=0
set noshowcmd
set noshowmode

" change cursor for mode
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
set ttyfast

" auto complete size
set pumheight=10

" netrw config
let g:netrw_banner = 0
let g:netrw_altv=1

" vim multiline
let g:VM_default_mappings = 0

" ai.vim config
let g:ai_no_mappings = 1
let g:ai_context_before = 20
let g:ai_context_after = 20

" vim copilot config
let g:copilot_filetypes = {
    \ 'markdown': v:true,
    \ 'terraform': v:true,
    \ 'tf': v:true,
\ }

" Copy github link
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

" git gutter
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_first_line = '│'
let g:gitgutter_sign_removed_above_and_below = '│'
let g:gitgutter_sign_modified_removed = '│'

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

" disable split term default mappins
let g:disable_key_mappings = 1

" git blamer
let g:blamer_enabled = 1

" tab rename
let g:taboo_renamed_tab_format = ' %N:%l%m '
let g:taboo_tab_format = ' %N:%f%m '
let g:taboo_modified_tab_flag = ' ~ '

" resize window key
let g:winresizer_start_key	= '<leader>e'

" session config
let g:prosession_dir = '~/.local/share/nvim/sessions/'
let g:prosession_on_startup = 1

" fzf config 
let g:fzf_buffers_jump = 1
let g:fzf_action = {
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
let $FZF_DEFAULT_OPTS .= ' --bind ctrl-a:select-all --bind ctrl-y:preview-up,ctrl-e:preview-down'
let $FZF_DEFAULT_OPTS .= ' --preview-window noborder --margin 0 --padding 0 --no-separator'

" wilder config
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

" system clibboard access
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
            au!
            au TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
endif

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
    setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    if &diff
        setlocal nolist
    endif
endfunction

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


function! s:list_sessions() abort
    return systemlist('ls -t ' . g:prosession_dir . ' | grep -v last_session | sed "s/%/\//g"')
endfunction

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

func! s:ToggleBreakpoint()
    if getline('.')=~#'^\s*breakpoint'
        exe 'silent! g/^\s*breakpoint()/d'
    else
        let indent = strlen(matchstr(getline(line('.') - 1), '^\s*'))
        if indent == 0
            let indent = strlen(matchstr(getline(line('.')), '^\s*'))
        endif
        cal append('.', repeat(' ', indent). 'breakpoint()')
        exec ':w'
    endif
endf

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

" zoom
function! ToogleZoom()
    let s:zoomed_in = (exists('s:zoomed_in') ? s:zoomed_in : 0) ? 0 : 1
    exe "normal \<C-W>" . (s:zoomed_in ? "\|\<C-W>_" : '=')
endfunction

" Git status
function! GitStatusAddBars()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a || m || r
        let total = a + m
        return '+' . total
    else
        return ''
    endif
endfunction

function! GitStatusRemoveBars()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a || m || r
        return '-' . (r + m)
    else
        return ''
    endif
endfunction

" Status Line Custom
function! ModeCurrent() abort
    let currentmode={
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
    let l:modecurrent = mode()
    let l:modelist = toupper(get(currentmode, l:modecurrent, 'V·Block'))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

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

" Status Line Custom
function SetStatusLine(active)
    let l:statusline = ''
    if a:active
        let l:statusline .= ' %#CurrentMode#'
        let l:statusline .= '%{ModeCurrent()} '
    endif
    let l:statusline .= '%*'
    let l:statusline .= '%#FileName#'
    let l:statusline .= '%f '
    let l:statusline .= '%#DiffHighlight#'
    let l:statusline .= '%#AddBardsHighlight#'
    let l:statusline .= '%{GitStatusAddBars()}'
    let l:statusline .= '%#RemoveBardsHighlight#'
    let l:statusline .= '%{GitStatusRemoveBars()}'
    let l:statusline .= '%=' " Right Side
    return l:statusline
endfunction
set statusline=%!SetStatusLine(1)

" augroup Statusline
"     au!
"     au WinEnter,BufEnter * setlocal statusline=%!SetStatusLine(1)
"     au WinLeave,BufLeave * setlocal statusline=%!SetStatusLine(0)
" augroup END

" tab length per file type
augroup file_format
    au!
    au FileType javascript set tabstop=2|set shiftwidth=2|set expandtab|setlocal nowrap
    au FileType jsx set tabstop=2|set shiftwidth=2|set expandtab
    au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    au FileType make setlocal noexpandtab
augroup END

" Call method on window enter
augroup WindowManagement
    au!
    au BufWinEnter,WinEnter * call Handle_Win_Enter()
augroup END

" comments config
augroup CommentsGroup
    au!
    au FileType vim setlocal commentstring=\"\ %s
    au FileType python setlocal commentstring=#\ %s
    au FileType sh setlocal commentstring=#\ %s
    au FileType awk setlocal commentstring=#\ %s
    au FileType javascript setlocal commentstring=//\ %s
    au FileType jsx setlocal commentstring=//\ %s
augroup END

" autorelaod files
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

" quickfix
augroup QuickFixCmds
    au!
    au FileType qf map  <buffer> <silent> dd :call RemoveFromQuickFix()<cr>
    au FileType qf map <buffer> <silent> <leader>q :call CloseQuickFix()<cr>
    au FileType qf :resize 8
augroup END

" if a swap file exists, open it in a new buffer
augroup SwapEditOption
    au!
    au SwapExists * let v:swapchoice = 'e'
augroup END

" fzf window
augroup fzfGroup
    au! FileType fzf setlocal laststatus=0 noshowmode noruler nonumber norelativenumber signcolumn=no
    \| au BufLeave <buffer> if &filetype != 'fzf' | set laststatus=2 noshowmode ruler signcolumn=yes cmdheight=0 | endif
augroup END

" Auto update plugins every week
augroup update_plug
    au!
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
    au VimEnter * call OnVimEnter()
augroup END

" quit vim window on term exit
augroup terminal_settings
    au!
    au BufWinEnter,WinEnter,BufLeave,BufNew quickfix stopinsert
    au BufWinEnter,WinEnter,BufLeave term://* setlocal nolist
    au BufWinEnter,WinEnter,BufLeave fugitive://* setlocal nolist
    au BufWinEnter,WinEnter term://* stopinsert
    " Ignore various filetypes as those will close terminal automatically
    " Ignore fzf, ranger, coc
    au TermClose term://*
          \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
          \   call nvim_input('<CR>')  |
          \ endif
augroup END

" fugitive mappings
augroup custom_fugitive_mappings
    au!
    " vimdiff in new tab
    function! GStatusGetFilenameUnderCursor()
        return matchstr(getline('.'), '^[A-Z?] \zs.*')
    endfunction

    command! GdiffsplitTab call GdiffsplitTab(expand("%"))
    function! GdiffsplitTab(filename)
        exe 'tabedit ' . a:filename
        Gvdiffsplit
    endfunction
    au User FugitiveIndex map <buffer> <space> =
    au User FugitiveIndex nnoremap <buffer> dt :call GdiffsplitTab(GStatusGetFilenameUnderCursor())<CR>
augroup END

" markdown fold
augroup fold_formats
    au!
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
    au BufEnter *.md setlocal foldexpr=MarkdownLevel()
    au BufEnter *.md setlocal foldmethod=expr
augroup END

" highlight the word under cursor (CursorMoved is inperformant)
augroup CWordHiGroup
    au!
    function! HighlightCursorWord()
        let cword = expand('<cword>')
        exe printf('match hiCursorWord /\V\<%s\>/', escape(cword, '/\'))
    endfunction
    au CursorHold * call HighlightCursorWord()
augroup END

" when leaving a buffer, delete all hidden buffers
augroup DeleteHiddenBuffers
    au!
    function DeleteHiddenBuffers()
        let tpbl=[]
        call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
        for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1 && bufname(v:val) !~# "^fugitive://"')
            silent! execute 'bwipeout' buf
        endfor
    endfunction
    au BufWinLeave * silent call DeleteHiddenBuffers()
augroup END

" auto run commands to disable cursorline when exiting a window, enable when entering
augroup Cursorline
    au!
    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" new tab shortcut
map <C-t> :tabe term://zsh<CR>

" fold and indent navigation
nnoremap <space> za
vnoremap <space> zf
nnoremap } zjzz
nnoremap { zkzz

" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
inoremap <C-a> <Home>
inoremap <C-e> <End>
nnoremap <C-a> <Home>
nnoremap <C-e> <End>

" comments
nmap <C-_> gcc
vmap <C-_> gc

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :let @/ = ""<CR><CR>

" select terminal commands output
nnoremap <silent> <S-UP> :call SelectCommand('up')<CR>
nnoremap <silent> <S-DOWN> :call SelectCommand('down')<CR>
vnoremap <silent> <S-UP> :call SelectCommand('up')<CR>
vnoremap <silent> <S-DOWN> :call SelectCommand('down')<CR>
tnoremap <silent> <S-UP> <C-\><C-n>:call SelectCommand('up')<CR>
tnoremap <silent> <S-DOWN> <C-\><C-n>:call SelectCommand('down')<CR>

" ai.vim maps
nnoremap <silent> <leader>f :AI<space>
inoremap <silent> <leader>f <esc>:AI<CR>
vnoremap <silent> <leader>f :AI<space>

" vim copilot maps
inoremap ‘ <Cmd>call copilot#Next()<CR>
inoremap “ <Cmd>call copilot#Previous()<CR>
inoremap « <Cmd>call copilot#Suggest()<CR>

" window shift
nnoremap <C-W>m <Cmd>WinShift<CR>
nnoremap <C-W><LEFT> <Cmd>WinShift left<CR>
nnoremap <C-W><DOWN> <Cmd>WinShift down<CR>
nnoremap <C-W><UP> <Cmd>WinShift up<CR>
nnoremap <C-W><RIGHT> <Cmd>WinShift right<CR>

" notes
map <leader>n :sp ~/Library/Mobile Documents/com~apple~CloudDocs/notes/<CR>

" vim coc
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" print current date
nnoremap <silent> <leader>td o<CR><C-D><C-R>="# " . strftime("%d-%m-%Y")<CR><CR><Esc>

" y behaves as other capital letters
nnoremap Y y$

" keep centered
nnoremap n nzzzv
nnoremap N Nzzzv

" search word under cursor
nnoremap # #N
nnoremap * *N

nnoremap <leader>z :call ToogleZoom()<CR>

" terminal commands
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

nnoremap <silent> <Leader>t :call SwitchToTerm()<cr>

map <C-Up> <C-W>k
map <C-Down> <C-W>j
map <C-Left> <C-W>h
map <C-Right> <C-W>l

" terminal binding
nnoremap <silent> <leader>s :Term<CR>
nnoremap <silent> <leader>d :VTerm<CR>

" marker
noremap M `

" breakpoint
nnoremap <leader>p :call <SID>ToggleBreakpoint()<CR>

" tabs
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

" window resize
nnoremap <silent> <leader>e :WinResizerStartResize<CR>

" Redo with U instead of Ctrl+R
nnoremap U <C-R>

nnoremap <silent><leader><space> :Files<CR>
nnoremap <silent><leader>b :Buffers<CR>
nnoremap <silent><C-f> :Rg<CR><C-P>
nnoremap <silent><C-s> :GFiles?<CR>
nnoremap <silent><C-r> :History:<CR>
nnoremap <silent><c-h> :Helptags<CR>

nnoremap <silent>K :call SearchWordWithRg()<CR>
vnoremap <silent>K :call SearchVisualSelectionWithRg()<CR>
nnoremap <c-\> :SessionPicker<cr>

" Open quick fix list
nnoremap <silent><leader>q :silent! :call OpenQuickFix()<cr>
" Add current line to quick fix list
nnoremap <silent><leader>x :call AddToQuickFix()<cr>

" custom mapping in fugitive window (:Git)
nnoremap <silent><leader>g :tab G<CR>
nnoremap <silent><leader>h :tabedit %<CR>:0Gclog<CR>:Gdiffsplit<CR>:setlocal nolist<CR>:setlocal signcolumn=no<CR>

"After <leader>h, navigate through the git history
map <silent> <expr> <C-j> &diff ? ':q<CR>:cn<CR>:Gdiffsplit<CR>:setlocal nolist<CR>:setlocal signcolumn=no<CR>' : '<C-j>'
map <silent> <expr> <C-k> &diff ? ':q<CR>:cp<CR>:Gdiffsplit<CR>:setlocal nolist<CR>:setlocal signcolumn=no<CR>' : '<C-k>'

" silent maps for [c and ]c for git gutter
nnoremap [c :silent! GitGutterPrevHunk<CR>
nnoremap ]c :silent! GitGutterNextHunk<CR>

" lua scripts
lua << EOF
    require "term-edit".setup { prompt_end = '%$ ' }
    require "which-key".setup {}
    require('nvim-treesitter.configs').setup {
        highlight = {
            enable = true,
        },
    }
    xpcall(
        function()
            require "winshift".setup { highlight_moving_win = false }
        end, 
        function(err)
        end
    )
EOF
