set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:python3_host_prog = '~/.pyenv/shims/python3.11'
let mapleader = ','
set encoding=utf-8
let g:coc_global_extensions = [
\ 'coc-pyright',
\ 'coc-json',
\ 'coc-html',
\ 'coc-css',
\ 'coc-vimlsp',
\ ]

call plug#begin('~/.vim/plugins')
    function! UpdateRemotePlugins(...)
        " Needed to refresh runtime files
        let &runtimepath=&runtimepath
        UpdateRemotePlugins
    endfunction
    Plug 'morhetz/gruvbox'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim', {'commit': '5ab282c2f4a597fa655f39f36e7ee8e97bf51650'}
    Plug 'vimlab/split-term.vim'
    Plug 'APZelos/blamer.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'jkramer/vim-checkbox'
    Plug 'tpope/vim-commentary'
    Plug 'gcmt/taboo.vim'
    Plug 'sindrets/winshift.nvim', {'branch': 'main'}
    Plug 'ruanyl/vim-gh-line'
    Plug 'neoclide/coc.nvim', {'branch': 'release' }
    Plug 'github/copilot.vim'
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'
    Plug 'maxmellon/vim-jsx-pretty', {'for': 'javascript'}
    Plug 'chomosuke/term-edit.nvim', {'tag': 'v1.*'}
    Plug 'jessekelighine/vindent.vim'
    Plug 'vim-scripts/argtextobj.vim', {'for': 'python'}
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'terryma/vim-expand-region'
    Plug 'lukas-reineke/indent-blankline.nvim', {'commit': '9637670896b68805430e2f72cf5d16be5b97a22a'}
    Plug 'antoinemadec/coc-fzf'
    Plug 'dohsimpson/vim-macroeditor'
    Plug 'bkad/CamelCaseMotion'
    Plug 'sindrets/diffview.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

" lua scripts
lua << EOF
    require "term-edit".setup { prompt_end = '%$ ' }
    require("CopilotChat").setup {
        debug = false,
        separator = '---',
        show_folds = false,
        show_help = false,
        auto_insert_mode = true,
        window = {
           layout = 'horizontal',
           height = 0.3,
        },
        mappings = {
            complete = {
                detail = 'Use <C-p>',
                insert ='<C-p>',
            },
            submit_prompt = {
                normal = '<CR>',
                insert = '<leader>c',
            },
            close = {
                normal = '<leader>c',
                insert = '<C-c>'
            },
        }
    }
    require("diffview").setup({
        use_icons = false,
        file_panel = {
            win_config = {
                position = "top",
                height = 16,
            },
        },
        file_history_panel = {
            win_config = {
                position = "top",
                height = 16,
            },
         },
    })
    require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = false,
        space_char_highlight_list = { "Whitespace" },
        char_highlight_list = { "Whitespace" },
        context_highlight_list = { "Whitespace" },
        char = '',
        context_char = '┃',
    }
    require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "terraform", "bash" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            -- disable = { "json" },
            additional_vim_regex_highlighting = false,
            use_languagetree = false,
            disable = function(_, bufnr)
                local buf_name = vim.api.nvim_buf_get_name(bufnr)
                local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
                return file_size > 256 * 1024
            end,
        }
    }
EOF

" session config
let g:prosession_dir = '~/.local/share/nvim/sessions/'
let g:procession_last_session_dir = '~/.local/share/nvim/sessions/'
let g:procession_default_session = 0
let g:obsession_no_bufenter = 0
let g:prosession_on_startup = 1

" theme
syntax on
filetype plugin on
filetype plugin indent off " space as tabs
set termguicolors
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif
colorscheme gruvbox

"========================================
"================= COLORS ===============
"========================================

" Background and foreground colors
hi Operator ctermbg=NONE guibg=NONE

" FZF colors
hi FZFBG ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

" Windows split
hi VertSplit ctermfg=None ctermbg=None guifg=NONE guibg=NONE

" todo highlight
hi def link MyTodo Todo

" Quickfix
hi link QuickFixLine CursorLine

function! SetDarkColors()
    " Background and foreground colors
    hi Normal ctermbg=16 ctermfg=247 guibg=#000000 guifg=#9e9e9e
    hi Operator ctermbg=NONE guibg=NONE

    " Background colors for active vs inactive windows
    hi ActiveWindow ctermbg=233 guibg=#121212
    hi InactiveWindow ctermbg=16 guibg=#000000
    hi MsgArea ctermfg=239 guifg=#4e4e4e
    hi WinSeparator ctermfg=16 ctermbg=16 guifg=#000000 guibg=#000000

    " invisible characters
    hi Whitespace ctermbg=NONE ctermfg=234 cterm=bold guibg=NONE guifg=#1c1c1c gui=bold
    hi Nontext ctermbg=NONE ctermfg=234 cterm=bold guibg=NONE guifg=#1c1c1c gui=bold
    hi Specialkey ctermbg=NONE ctermfg=234 cterm=bold guibg=NONE guifg=#1c1c1c gui=bold
    hi Comment ctermfg=239 guifg=#4e4e4e gui=italic

    "highlight clear cursorline
    hi cursorlinenr ctermbg=NONE cterm=bold guibg=NONE gui=bold
    hi cursorline ctermbg=235 guibg=#262626
    hi Visual ctermbg=237 cterm=NONE guibg=#303030 gui=NONE
    hi Search cterm=inverse ctermfg=NONE guifg=NONE gui=inverse
    hi cursorcolumn ctermbg=235 guibg=#262626
    hi Blamer ctermfg=239 ctermbg=NONE guifg=#4e4e4e gui=italic
    hi LineNr ctermfg=235 cterm=bold guifg=#262626 gui=bold
    hi HiCursorWord ctermbg=236 guibg=#303030

    " Fold
    hi Folded ctermbg=NONE ctermfg=239 guibg=NONE guifg=#4e4e4e
    hi FoldColumn ctermbg=NONE ctermfg=235 guibg=NONE guifg=#3a3a3a

    " FZF colors
    hi BorderFZF ctermfg=233 guifg=#4e4e4e
    hi TextFZF ctermfg=245 guifg=#8a8a8a

    " Auto complete menu
    hi Pmenu ctermfg=240 ctermbg=233 guifg=#585858 guibg=#121212
    hi PmenuSel ctermfg=233 ctermbg=108 guifg=#121212 guibg=#87af87
    hi CocFloating ctermfg=240 ctermbg=233 guifg=#585858 guibg=#121212
    hi CocMenuSel ctermfg=233 ctermbg=108 guifg=#121212 guibg=#87af87

    " Windows split
    hi StatusLineNC ctermfg=16 ctermbg=237 guibg=#000000 guifg=#3a3a3a gui=NONE
    hi StatusLine ctermfg=16 ctermbg=241 guibg=#000000 guifg=#626262 gui=NONE

    " Status line components
    hi AddBardsHighlight ctermfg=106 cterm=italic guifg=#87af01 gui=italic
    hi RemoveBardsHighlight ctermfg=131 cterm=italic guifg=#d75f5f gui=italic
    hi DiffHighlight ctermfg=246 cterm=italic guifg=#d7af5f gui=italic
    hi FileName ctermfg=236 cterm=italic guifg=#303030 gui=italic
    hi CurrentMode ctermfg=236 cterm=bold guifg=#303030 gui=bold
    hi GitBranch ctermfg=236 cterm=italic,bold guifg=#303030 gui=italic,bold

    " tab styling
    hi TabLineFill ctermfg=235 ctermbg=16 guifg=#3a3a3a guibg=#000000
    hi TabLine ctermfg=237 ctermbg=16 cterm=NONE guifg=#3a3a3a guibg=#000000 gui=NONE
    hi TabLineSel ctermfg=241 ctermbg=233 cterm=bold guifg=#626262 guibg=#121212 gui=bold
    hi Title ctermfg=214 cterm=bold guifg=#ffaf01 gui=bold

    " command line
    hi PmenuCustom cterm=bold ctermfg=red ctermbg=NONE guifg=#d75f5f guibg=NONE gui=bold
    hi PmenuSelCustom ctermbg=233 guibg=#121212
    hi PmenuTextCustom ctermfg=240 ctermbg=16 guifg=#585858 guibg=#000000

    " which key
    hi WhichKeyFloat ctermbg=16 ctermfg=239 guibg=#000000 guifg=#4e4e4e
    hi WhichKeyDesc	ctermfg=239 guifg=#4e4e4e
    hi WhichKey	ctermfg=red guifg=#d75f5f

    " Git gutter and vimdiff
    hi clear SignColumn
    hi GitGutterAdd ctermfg=108 guifg=#87af87
    hi GitGutterChange ctermfg=108 guifg=#87af87
    hi GitGutterDelete ctermfg=131 guifg=#d75f5f
    hi GitGutterChangeDelete ctermfg=108 guifg=#87af87
    hi GitGutterAddLineNr ctermfg=108 cterm=bold guifg=#87af87 gui=bold
    hi GitGutterChangeLineNr ctermfg=108 cterm=bold guifg=#87af87 gui=bold
    hi GitGutterDeleteLineNr ctermfg=131 cterm=bold guifg=#d75f5f gui=bold
    hi GitGutterChangeDeleteLineNr ctermfg=108 cterm=bold guifg=#87af87 gui=bold
    hi DiffAdd ctermfg=NONE ctermbg=17 cterm=NONE guifg=NONE guibg=#033904 gui=NONE
    hi DiffChange ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=#042505 gui=NONE
    hi DiffDelete ctermfg=NONE ctermbg=52 cterm=NONE guifg=NONE guibg=#5f0000 gui=NONE
    hi DiffText ctermfg=NONE ctermbg=17 cterm=NONE guifg=NONE guibg=#033904 gui=bold
    hi DiffviewFilePanelFileName ctermfg=247 guifg=#9e9e9e
endfunction

" light colors
function! SetLightColors()
    " Background and foreground colors
    hi Normal ctermbg=254 ctermfg=241 guibg=#f2f2f2 guifg=#303030
    hi Operator ctermbg=NONE guibg=NONE

    " Background colors for active vs inactive windows
    hi ActiveWindow ctermbg=254 guibg=#f2f2f2
    hi InactiveWindow ctermbg=253 guibg=#e5e5e5
    hi MsgArea ctermfg=248 ctermbg=253 guifg=#7f7f7f guibg=#e5e5e5
    hi WinSeparator ctermfg=253 ctermbg=253 guifg=#e5e5e5 guibg=#e5e5e5

    "invisible characters
    hi Whitespace ctermbg=NONE ctermfg=253 cterm=bold guibg=NONE guifg=#b3b3b3 gui=bold
    hi Nontext ctermbg=NONE ctermfg=253 cterm=bold guibg=NONE guifg=#b3b3b3 gui=bold
    hi Specialkey ctermbg=NONE ctermfg=253 cterm=bold guibg=NONE guifg=#b3b3b3 gui=bold
    hi Comment cterm=italic ctermfg=247 guifg=#9e9e9e gui=italic

    "highlight clear cursorline
    hi cursorlinenr ctermbg=NONE cterm=bold guibg=NONE gui=bold
    hi cursorline ctermbg=252 guibg=#f0f0f0
    hi Visual ctermbg=250 cterm=NONE guibg=#f0f0f0 gui=NONE
    hi Search cterm=inverse ctermfg=NONE guifg=NONE gui=inverse
    hi cursorcolumn ctermbg=252 guibg=#f0f0f0
    hi Blamer ctermfg=247 ctermbg=NONE cterm=italic guifg=#9e9e9e gui=italic
    hi LineNr ctermfg=252 cterm=bold guifg=#f0f0f0 gui=bold
    hi HiCursorWord ctermbg=252 guibg=#f0f0f0

    " Fold
    hi Folded ctermbg=NONE ctermfg=247 guibg=NONE guifg=#9e9e9e
    hi FoldColumn ctermbg=NONE ctermfg=253 guibg=NONE guifg=#e5e5e5

    " FZF colors
    hi BorderFZF ctermfg=253 guifg=#e5e5e5
    hi TextFZF ctermfg=245 guifg=#7f7f7f

    " Auto complete menu
    hi Pmenu ctermfg=240 ctermbg=253 guifg=#585858 guibg=#e5e5e5
    hi PmenuSel ctermfg=253 ctermbg=250 guifg=#e5e5e5 guibg=#f2f2f2
    hi CocFloating ctermfg=240 ctermbg=253 guifg=#585858 guibg=#e5e5e5
    hi CocMenuSel ctermfg=253 ctermbg=250 guifg=#e5e5e5 guibg=#f2f2f2

    " Windows split
    hi StatusLineNC ctermfg=253 guifg=#e5e5e5
    hi StatusLine ctermfg=253 guifg=#e5e5e5

    " Status line components
    hi AddBardsHighlight ctermfg=106 cterm=italic ctermbg=253 guifg=#87af01 gui=italic guibg=#f2f2f2
    hi RemoveBardsHighlight ctermfg=131 cterm=italic ctermbg=253 guifg=#d75f5f gui=italic guibg=#f2f2f2
    hi DiffHighlight ctermfg=246 cterm=italic guifg=#d7af5f gui=italic
    hi FileName ctermfg=249 cterm=italic ctermbg=253 guifg=#7f7f7f gui=italic guibg=#e5e5e5
    hi CurrentMode ctermfg=249 cterm=bold ctermbg=253 guifg=#7f7f7f gui=bold guibg=#e5e5e5
    hi GitBranch ctermfg=249 cterm=italic,bold ctermbg=253 guifg=#7f7f7f gui=italic,bold guibg=#e5e5e5

    " tab styling
    hi TabLineFill ctermfg=253 ctermbg=253 guifg=#e5e5e5 guibg=#e5e5e5
    hi TabLine ctermfg=250 ctermbg=253 cterm=NONE guifg=#f0f0f0 guibg=#e5e5e5 gui=NONE
    hi TabLineSel ctermfg=254 ctermbg=252 cterm=bold guifg=#303030 guibg=#f0f0f0 gui=bold
    hi Title ctermfg=214 cterm=bold guifg=#ffaf01 gui=bold

    " command line
    hi PmenuCustom cterm=bold ctermfg=red ctermbg=NONE guifg=#d75f5f guibg=NONE gui=bold
    hi PmenuSelCustom ctermbg=253 guibg=#e5e5e5
    hi PmenuTextCustom ctermfg=240 ctermbg=253 guifg=#585858 guibg=#e5e5e5

    " which key
    hi WhichKeyFloat ctermbg=253 ctermfg=247 guibg=#e5e5e5 guifg=#9e9e9e
    hi WhichKeyDesc	ctermfg=247 guifg=#9e9e9e
    hi WhichKey	ctermfg=red guifg=#d75f5f

    " Git gutter and vimdiff
    hi clear SignColumn
    hi GitGutterAdd ctermfg=108 ctermbg=NONE guifg=#87af87
    hi GitGutterChange ctermfg=108 ctermbg=NONE guifg=#87af87
    hi GitGutterDelete ctermfg=131 ctermbg=NONE guifg=#d75f5f
    hi GitGutterChangeDelete ctermfg=108 ctermbg=NONE guifg=#87af87 guibg=NONE
    hi GitGutterAddLineNr ctermfg=108 cterm=bold guifg=#87af87 gui=bold
    hi GitGutterChangeLineNr ctermfg=108 cterm=bold guifg=#87af87 gui=bold
    hi GitGutterDeleteLineNr ctermfg=131 cterm=bold guifg=#d75f5f gui=bold
    hi GitGutterChangeDeleteLineNr ctermfg=108 cterm=bold guifg=#87af87 gui=bold
    hi DiffAdd ctermfg=NONE ctermbg=108 cterm=NONE guifg=NONE guibg=#87af87 gui=NONE
    hi DiffChange ctermfg=NONE ctermbg=108 cterm=NONE guifg=NONE guibg=#87af87 gui=NONE
    hi DiffDelete ctermfg=NONE ctermbg=131 cterm=NONE guifg=NONE guibg=#d75f5f gui=NONE
    hi DiffText ctermfg=NONE ctermbg=108 cterm=NONE guifg=NONE guibg=#87af87 gui=NONE
    hi DiffviewFilePanelFileName ctermfg=241 guifg=#626262
endfunction

if &background ==# 'light'
    call SetLightColors()
else
    call SetDarkColors()
endif

"========================================
"================= OPTIONS ==============
"========================================

set shell=$SHELL
set number
set relativenumber
set scrolloff=10
set backspace=indent,eol,start
set nowrap
set linebreak
set autoindent
set nohidden
set winminheight=0
set winminwidth=0
set signcolumn=no
set updatetime=50
set timeout
set ttimeout
set timeoutlen=250
set mouse=a
set mousescroll=ver:5
set viminfo='100,f1
set noswapfile
set lazyredraw

" session config
set sessionoptions+=winpos

" do not store global and local values in a session
set sessionoptions-=options,blank,terminal

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
set cursorlineopt=number,line

" status column
" let &stc='%s %=%#LineNr#%{v:lnum}  %#NonText#%{v:relnum ? v:relnum : v:lnum} %T %s'
" let &stc='%= %#NonText#%{v:relnum ? v:relnum : v:lnum} %T %s'

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
set fillchars+=eob:\ 
set fillchars+=diff:\ 
set splitbelow
set splitright

" statusline
if exists('g:started_by_firenvim') && g:started_by_firenvim
    set laststatus=0
else
    set laststatus=2
endif
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
    \ '*': v:true,
\ }

" Copy github link
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

" git gutter
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_removed_above_and_below = ''
let g:gitgutter_sign_modified_removed = ''
let g:gitgutter_signs=0
let g:gitgutter_highlight_linenrs=1

"Linters
let b:coc_diagnostic_disable = 1

" disable split term default mappins
let g:disable_key_mappings = 1

" git blamer
if exists('g:started_by_firenvim') && g:started_by_firenvim
    let g:blamer_enabled = 0
else
    let g:blamer_enabled = 1
endif

" tab rename
let g:taboo_tab_format = ' %N '

" fzf config
let g:fzf_buffers_jump = 1
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-d': 'vsplit'
\ }

let g:coc_fzf_preview = 'right:50%'

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

let g:fzf_layout = { 'up': '~40%' }
" let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'relative': v:true, 'yoffset': 0 } }

" ctrl-e/y to navigate cmd history
let g:fzf_history_dir = '~/.fzf-history'
let $FZF_DEFAULT_OPTS = '--inline-info --layout=reverse-list --border=none --no-scrollbar'
let $FZF_DEFAULT_OPTS .= ' --bind ctrl-a:select-all --bind ctrl-y:preview-up,ctrl-e:preview-down'
let $FZF_DEFAULT_OPTS .= ' --preview-window 45%,noborder --margin=0 --padding=0 --no-separator --color dark'

" vindent
let g:vindent_begin = 0
let g:vindent_motion_OO_prev   = '[=' " jump to prev block of same indent.
let g:vindent_motion_OO_next   = ']=' " jump to next block of same indent.
let g:vindent_motion_more_prev = '[+' " jump to prev line with more indent.
let g:vindent_motion_more_next = ']+' " jump to next line with more indent.
let g:vindent_motion_less_prev = '[-' " jump to prev line with less indent.
let g:vindent_motion_less_next = ']-' " jump to next line with less indent.
let g:vindent_motion_diff_prev = '<S-UP>' " jump to prev line with different indent.
let g:vindent_motion_diff_next = '<S-DOWN>' " jump to next line with different indent.
let g:vindent_motion_XX_ss     = '[[' " jump to start of the current block scope.
let g:vindent_motion_XX_se     = ']]' " jump to end   of the current block scope.
let g:vindent_object_XX_ii     = 'ii' " select current block.
let g:vindent_object_XX_ai     = 'ai' " select current block + one extra line  at beginning.
let g:vindent_object_XX_aI     = 'aI' " select current block + two extra lines at beginning and end.
let g:vindent_jumps            = 1    " make vindent motion count as a |jump-motion| (works with |jumplist|).

let g:camelcasemotion_key = '<leader>'

" expand region definition
" 'i]' Support nesting of square brackets
" 'ib' Support nesting of parentheses
" 'iB' Support nesting of braces
" 'il' 'inside line'. Available through https://github.com/kana/vim-textobj-line
" 'ie' 'entire file'. Available through https://github.com/kana/vim-textobj-entire
let g:expand_region_text_objects = {
  \ 'iw'  :0,
  \ 'iW'  :0,
  \ 'i"'  :0,
  \ 'i''' :0,
  \ 'i]'  :1,
  \ 'ib'  :1,
  \ 'iB'  :1,
  \ 'il'  :0,
  \ 'ip'  :0,
  \ 'ie'  :0,
\ }

" expand region
call expand_region#custom_text_objects({ 'ia' :1 })

" wilder config
call wilder#setup({'modes': [':']})
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

"============================================
"================= FUNCTIONS ================
"============================================

" Open ranger in a terminal buffer
function! OpenRanger()
    let rangerCallback = { 'name': 'ranger' }
    function! rangerCallback.on_exit(id, code)
      try
        if filereadable('/tmp/chosenfile')
            exec 'edit ' . readfile('/tmp/chosenfile')[0]
            call system('rm /tmp/chosenfile')
        endif
      endtry
    endfunction
    enew
    call termopen('ranger --choosefile=/tmp/chosenfile', rangerCallback)
    startinsert
endfunction

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

function! s:source_session(lines) abort
    let key = a:lines[0]
    let original_file_name = '~/' . a:lines[1]
    let dir = substitute(original_file_name, '\.vim$', '', '')
    let last_dir = split(dir, '/')[-1]
    if key ==# 'ctrl-x'
        " silent! exec '!rm ' . file
        " :SessionPicker
    else
        silent! exec '!tmux select-window -t ' . last_dir . ' || tmux new-window -n ' . last_dir . ' -c ' . dir . ' nvim'
     endif
endfunction

command! SessionPicker call fzf#run(fzf#wrap({
    \ 'source': 'fd . $HOME --type d --max-depth=5 --exec-batch ls -ltd -1 | sed "s|$HOME/||"',
    \ 'sink*': { lines -> s:source_session(lines) },
    \ 'options': "--expect=ctrl-x"
\ }))

function! s:open_pr_diff(lines) abort
    let pr = a:lines[0]
    let pr = matchstr(pr, '\d\+')
    exec '!gh pr checkout ' . pr
endfunction

command! ListPRs call fzf#run(fzf#wrap({
    \ 'source': "gh pr list",
    \ 'options': "--preview 'gh pr diff --color=always {1} | delta --width $(expr $(tput cols) / 2)' --preview-window=right,50%",
    \ 'sink*': { lines -> s:open_pr_diff(lines) },
\ }))

function! SearchWordWithRg()
    let word = expand('<cword>')
    execute 'Rg'
    call feedkeys(word)
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
        let l:statusline .= '%#GitBranch#'
        let l:statusline .= '%{FugitiveHead()} '
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
    if a:active
        let l:statusline .= '%#FileName#'
        let l:statusline .= '%l:%c '
    endif
    if &filetype ==# 'fzf'
        let l:statusline = ''
    endif
    return l:statusline
endfunction
set statusline=%!SetStatusLine(1)

"============================================
"==================AUGROUPS==================
"============================================

augroup vimrc_todo
    au!
    syn case ignore
    highlight def link inProgress Normal
    highlight def link itemComplete Comment
    highlight def link location Number
    au Syntax * syn match inProgress "\[ ] .\+"
    au Syntax * syn match itemComplete "\[x] .\+"
augroup END

augroup MacroMessage
    au!
    au RecordingEnter * set cmdheight=1
    au RecordingLeave * set cmdheight=0
augroup END

augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!SetStatusLine(1)
    au WinLeave,BufLeave * setlocal statusline=%!SetStatusLine(0)
augroup END

" tab length per file type
augroup file_format
    au!
    au FileType json,ts,tsx,typescript,typescriptreact,jsx,javascript setlocal ts=2 sw=2 expandtab
    au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    au FileType markdown setlocal ts=2 sts=2 sw=2 expandtab
    au FileType make setlocal noexpandtab
    au FileType zsh setlocal filetype=sh
    au FileType python setlocal ts=4 sts=4 sw=4 expandtab
    au FileType terraform setlocal ts=2 sts=2 sw=2 expandtab
    au Filetype kotlin setlocal ts=4 sts=4 sw=4 expandtab
    au BufNewFile,BufRead requirements.txt setlocal filetype=requirements
    au BufNewFile,BufRead Brewfile setlocal filetype=python
augroup END

"if filename starts with /private/tmp, run bufhidden=wipe
augroup tmp_files
    au!
    au BufNewFile,BufRead /private/* setlocal bufhidden=wipe
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
    au FileType python,yaml setlocal commentstring=#\ %s
    au FileType sh setlocal commentstring=#\ %s
    au FileType awk setlocal commentstring=#\ %s
    au FileType haskell,hs setlocal commentstring=--\ %s
    au FileType tsx,ts,typescriptreact,jsx,javascript,kotlin,kt setlocal commentstring=//\ %s
    au FileType tf,terraform setlocal commentstring=#\ %s
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
    au FileType qf :resize 8
augroup END

" if a swap file exists, open it in a new buffer
augroup SwapEditOption
    au!
    au SwapExists * let v:swapchoice = 'e'
augroup END

" fzf window
augroup fzfGroup
    au! User FzfStatusLine setlocal statusline=
    au! FileType fzf setlocal laststatus=0 noshowmode noruler nonumber norelativenumber signcolumn=no
    \| au BufLeave <buffer> if &filetype == 'fzf' | set laststatus=2 noshowmode ruler signcolumn=yes cmdheight=0 | endif
    au BufEnter * if &filetype == 'fzf' | setlocal laststatus=0 noshowmode noruler nonumber norelativenumber signcolumn=no | endif
augroup END

augroup yankhighlight
    au!
    hi HighlightedyankRegion ctermbg=236
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=500}
augroup END

augroup update_plug
    au!
    function! OnVimEnter() abort
        let l:project_name = expand('%:p:h:t')
        if l:project_name !~# 'dotfiles'
            return
        endif

        " rollback:
        " !git checkout -- plug.snapshot.vim
        " silent! source plug.snapshot.vim

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
    au BufLeave * if &filetype == 'vim-plug' | silent! PlugSnapshot! ~/dev/dotfiles/plug.snapshot.vim | endif
    au BufLeave * if expand('%:t') == 'plug.snapshot.vim' | silent! %s/^\(silent!.*\|PlugUpdate\)\@!.*\n//g | silent w | endif

augroup END

" auto resize windows
augroup auto_resize
    au!
    au VimResized * wincmd =
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

augroup line_numbers_toggle
    au!
    au InsertEnter * :set norelativenumber
    au InsertLeave * :set relativenumber 
    au BufEnter * :set relativenumber
    au BufLeave * :set norelativenumber
augroup END

augroup slack_filetype
    au!
    au BufEnter app.slack.com_*.txt set filetype=markdown
augroup END

function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set lines=5
  endif
endfunction

autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

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

" set spell for markdown files only
" use [s and ]s to jump to misspelled words
" use z= to pull up suggested words
" zg to add to dictionary.
augroup markdown_spell
    au!
    au BufEnter *.md setlocal spell spelllang=en_us
    au BufLeave *.md setlocal nospell
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
" augroup DeleteHiddenBuffers
"     au!
"     function DeleteHiddenBuffers()
"         let tpbl=[]
"         call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
"         for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1 && bufname(v:val) !~# "^fugitive://"')
"             silent! execute 'bwipeout' buf
"         endfor
"     endfunction
"     au BufWinLeave * silent call DeleteHiddenBuffers()
" augroup END

" auto run commands to disable cursorline when exiting a window, enable when entering
augroup Cursorline
    au!
    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

"============================================
"================== MAPPINGS ================
"============================================

" new tab shortcut
map <C-t> :tabe term://zsh<CR>

" fold and indent navigation
function! ToggleFold()
    if !exists('w:fold_state')
        let w:fold_state = 0
    endif
    try
        if w:fold_state == 0
            execute 'normal! za'
        else
            execute 'normal! zA'
        endif
        let w:fold_state = 0
    catch
        if w:fold_state == 0
            execute 'normal! zM'
            let w:fold_state = 1
        else
            execute 'normal! zR'
            let w:fold_state = 0
        endif
    endtry
endfunction

nnoremap <space> :call ToggleFold()<CR>
vnoremap <space> zf

" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
inoremap <C-a> <Home>
inoremap <C-e> <End>
nnoremap <C-a> <Home>
nnoremap <C-e> <End>

" arrow movement like b/w 
nnoremap <silent> <S-LEFT> <Plug>CamelCaseMotion_b
nnoremap <silent> <S-RIGHT> <Plug>CamelCaseMotion_w
nnoremap <silent> <LEFT> h
nnoremap <silent> <RIGHT> l

" comments
nmap <C-_> gcc
vmap <C-_> gc

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :let @/ = ""<CR><CR>

" select terminal commands output
" nnoremap <silent> <S-UP> :call SelectCommand('up')<CR>
" nnoremap <silent> <S-DOWN> :call SelectCommand('down')<CR>
" vnoremap <silent> <S-UP> :call SelectCommand('up')<CR>
" vnoremap <silent> <S-DOWN> :call SelectCommand('down')<CR>
" tnoremap <silent> <S-UP> <C-\><C-n>:call SelectCommand('up')<CR>
" tnoremap <silent> <S-DOWN> <C-\><C-n>:call SelectCommand('down')<CR>
tnoremap <silent> <S-LEFT> <C-\><C-n><S-LEFT>
tnoremap <silent> <S-RIGHT> <C-\><C-n><S-RIGHT>
tnoremap <silent> <C-[> <C-\><C-n>

" ai.vim maps
nnoremap <silent> <leader>f :CopilotChatFix<space>
vnoremap <silent> <leader>f :CopilotChatFix<space>

" trigger chat
xnoremap <leader>c :CopilotChat<CR><Esc><C-w>=gi
nnoremap <leader>c :CopilotChat<CR><Esc><C-w>=gi
inoremap <leader>c <Esc>:CopilotChat<CR><Esc><C-w>=gi

" vim copilot maps
inoremap ‘ <Cmd>call copilot#Next()<CR>
inoremap “ <Cmd>call copilot#Previous()<CR>
inoremap « <Cmd>call copilot#Suggest()<CR>
inoremap <S-RIGHT> <Plug>(copilot-accept-word)

" window shift
nnoremap <C-W>m <Cmd>WinShift<CR>
nnoremap <C-W><LEFT> <Cmd>WinShift left<CR>
nnoremap <C-W><DOWN> <Cmd>WinShift down<CR>
nnoremap <C-W><UP> <Cmd>WinShift up<CR>
nnoremap <C-W><RIGHT> <Cmd>WinShift right<CR>

" notes
map <leader>nn :sp ~/Library/Mobile Documents/com~apple~CloudDocs/notes/<C-R>=substitute(getcwd(), '^.*/', '', '')<CR>.md<CR>
map <leader>n :sp ~/Library/Mobile Documents/com~apple~CloudDocs/notes/index.md<CR>
nnoremap <silent> <leader>td :call UpdateTodoList()<CR>

function! UpdateTodoList()
    let l:filename = expand('%:p')
    let l:current_date = strftime("%d-%m-%Y")
    let l:lines = readfile(l:filename)
    let l:new_lines = []
    let l:incomplete_tasks = []
    let l:date_exists = 0
    let l:date_index = -1

    " Iterate through the lines to find incomplete tasks and check if the current date exists
    for l:i in range(len(l:lines))
    let l:line = l:lines[l:i]
    if l:line =~ '^# \d\{2}-\d\{2}-\d\{4}$'
      call add(l:new_lines, l:line)
      if l:line == '# ' . l:current_date
        let l:date_exists = 1
        let l:date_index = l:i
      endif
    elseif l:line =~ '^\s\{2,}\[ \] '
      call add(l:incomplete_tasks, l:line)
    else
      call add(l:new_lines, l:line)
    endif
    endfor

    " Add the new date and incomplete tasks if the date doesn't exist
    if !l:date_exists
    call add(l:new_lines, '')
    call add(l:new_lines, '# ' . l:current_date)
    call extend(l:new_lines, l:incomplete_tasks)
    else
    " Insert incomplete tasks under the current date section
    call extend(l:new_lines, l:incomplete_tasks, l:date_index + 1)
    endif

    " Write the updated lines back to the file
    call writefile(l:new_lines, l:filename)
endfunction

" yank line with column and line number, and line content
nnoremap <leader>y :let @+ = expand('%') . '\|' . line('.') . ' col ' . col('.') . '\|' . substitute(getline('.'), '^\s\+', '', '')<CR>

" expand on click
map + <Plug>(expand_region_expand)
map _ <Plug>(expand_region_shrink)
"map <LeftMouse> <LeftMouse><Plug>(expand_region_expand)
"map <2-LeftMouse> <Plug>(expand_region_expand)
"map <3-LeftMouse> <Plug>(expand_region_expand)
"map <4-LeftMouse> <Plug>(expand_region_expand)

" Use K to show documentation in preview window
nnoremap <silent> L :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('L', 'in')
  endif
endfunction

" y behaves as other capital letters
nnoremap Y y$

" keep centered
nnoremap n nzzzv
nnoremap N Nzzzv

" search word under cursor
nnoremap # #N
nnoremap * *N

nnoremap <leader>z :call ToogleZoom()<CR>

" toogle background from dark to light on <leader>l
nnoremap <leader>l :call ToggleBackground()<CR>

function! ToggleBackground()
    if &background ==# 'dark'
        set background=light
        colorscheme gruvbox
        call SetLightColors()
    else
        set background=dark
        colorscheme gruvbox
        call SetDarkColors()
    endif
endfunction

" terminal commands
tnoremap <Esc> <C-\><C-n>
tnoremap <silent><C-f> <C-\><C-n>:Rg<CR>
tnoremap <silent><leader>x <C-\><C-n>:call AddToQuickFix()<cr>
tnoremap <silent><leader>s <C-\><C-n>:Term<CR>
tnoremap <silent><leader>r <C-\><C-n>:q<CR>:Term<CR>
tnoremap <silent><leader>z <C-\><C-n><C-W>\|<C-W>_
tnoremap <silent><leader>d <C-\><C-n>:VTerm<CR>
tnoremap <silent><leader>v <C-X><C-E><CR>
tnoremap <C-Up> <C-\><C-n><C-W>k
tnoremap <C-Down> <C-\><C-n><C-W>j
tnoremap <C-Left> <C-\><C-n><C-W>h
tnoremap <C-Right> <C-\><C-n><C-W>l
tnoremap <C-]> <C-\><C-n>:SessionPicker<CR>


nnoremap <silent> <Leader>t :call SwitchToTerm()<cr>

map <C-Up> <C-W>k
map <C-Down> <C-W>j
map <C-Left> <C-W>h
map <C-Right> <C-W>l

" terminal binding
nnoremap <silent> <leader>s :Term<CR>
nnoremap <silent> <leader>d :VTerm<CR>
nnoremap <silent> <leader>r :q<CR>:Term<CR>

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

" Dont copy to clipboard deleted text
nnoremap d "_d
vnoremap d "_d

" auto open fold when jumping to line
cmap <silent> <expr> <CR> getcmdtype() == ':' && getcmdline() =~ '^\d\+$' ? 'normal! zv<CR>' : '<CR>'

" quickly exit
nnoremap <silent> ZZ :wqa!<CR>

" paste in next line
nmap p :pu<CR>

" Redo with U instead of Ctrl+R
nnoremap U <C-R>

nnoremap <silent><leader><space> :Files<CR>
nnoremap <silent><leader>b :Buffers<CR>
nnoremap <silent><C-f> :Rg<CR>

function! GFilesWithFocus()
    let current_dir = getcwd()
    call fzf#vim#gitfiles('?', fzf#vim#with_preview({ "placeholder": "", 'dir': getcwd()}))
endfunction

" Coc
nnoremap <silent><leader>o :<C-u>CocFzfList outline<CR>
nnoremap <silent><leader>a :<C-u>CocFzfList diagnostics --current-buf<CR>

nnoremap <silent><C-s> :call GFilesWithFocus()<CR>
nnoremap <silent><C-r> :History:<CR>
nnoremap <silent><c-h> :Helptags<CR>

nnoremap <silent>K :call SearchWordWithRg()<CR>
vnoremap <silent>K :call SearchVisualSelectionWithRg()<CR>
nnoremap <silent><c-]> :SessionPicker<cr>
nnoremap <silent><c-l> :ListPRs<cr>

" Add current line to quick fix list
nnoremap <silent><leader>x :call AddToQuickFix()<cr>

nnoremap <silent><leader>g :DiffviewOpen<CR>
nnoremap <silent><leader>h :BCommits<CR>
vnoremap <silent><leader>h :BCommits<CR>

" silent maps for [c and ]c for git gutter and vimdiff
map <silent> <expr> [c &diff ? '[c' : ':silent! GitGutterPrevHunk<CR>'
map <silent> <expr> ]c &diff ? ']c' : ':silent! GitGutterNextHunk<CR>'

" macros
nmap gq qm
nmap Q @m
" nnoremap q <Nop>
nmap <leader>q :MacroEdit m<cr>

" ctrl-c maps to esc for insertleave
ino <C-C> <Esc>

" reopen last window
nnoremap <silent> <S-t> :vs<bar>:b#<CR>

" map the first spell check suggestion to z= (1z=)
nnoremap <silent> z= 1z=
