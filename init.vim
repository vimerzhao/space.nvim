" Copyright 2021 vimerzhao
"
" Author: vimerzhao
" Email:  vimerzhao@gmail.com
"
" 一、 为什么要维护这份配置
"
" 是否可以让部分配置延迟加载

" =============================================================================
"                       Part1: 基础配置
" =============================================================================

" no compatible with Vi
set nocompatible

set number relativenumber
highlight LineNr ctermfg=grey
set cursorline
highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE guibg=NONE guifg=NONE

set encoding=utf-8 fileencodings=utf-8 termencoding=utf-8

set tabstop=2 shiftwidth=2 expandtab autoindent

" 合理的代码会自己控制长度，所以优先考虑不拆行
set nowrap
" 配合nowrap使用，提升超长行的可读性
set sidescrolloff=15
" 上下滚动时，始终和边界保持5行距离，提升可读性
set scrolloff=5
"开启语法高亮
syntax on
" 编辑多个文件时，将工作目录自动切换到，正在编辑的文件的目录
set autochdir
" 如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示
set autoread

"突出显示不可见字符. Ref: http://yyq123.blogspot.com/2011/11/vim-listchars.html
set list
set listchars=tab:»■,precedes:«,extends:»,trail:■

" 配置弹出框的样式
highlight PMenu ctermfg=34 ctermbg=237 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=40 ctermbg=240 guifg=darkgrey guibg=black


" =============================================================================
"                       Part2: Leader配置
" =============================================================================
" 基本原则：
"   1. 使用频率越高，触发路径越容易
"   2. Spacemacs在用快捷键，尽量保持一致
"
" 命名参考：
"   f -> file
"   F -> Function
"   w -> window
" https://stackoverflow.com/questions/446269/can-i-use-space-as-mapleader-in-vim
map <Space> <Leader>
" Part2.1文件管理器
nnoremap <leader>ft :NERDTreeToggle<CR>

" Part2.2 窗口操作
nmap <Leader>w <C-w>
nmap <Leader>w- :split<CR>
nmap <Leader>w/ :vsplit<CR>

" Part2.3 LeadF
noremap <Leader>fm :LeaderfMru<cr>
noremap <Leader>ff :LeaderfFile<cr>

" =============================================================================
"                       Part3: 插件配置
" =============================================================================
" 开始配置插件，使用vim-plug管理（Vundle已经不维护了）
" TODO 后续还要多每个插件深入了解，进行更合理的配置
call plug#begin('~/.vim/plugged')
Plug 'Yggdroot/indentLine'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'mhinz/vim-signify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/LeaderF'
Plug 'ludovicchabant/vim-gutentags'

call plug#end()


" -----------------------------------------------------------------------------
" 插件配置

" Part3.1 indentLine
let g:indent_guides_guide_size            = 1
let g:indent_guides_start_level           = 2

" Part3.2 nerdtree
" 最后一个Buffer时直接退出: https://stackoverflow.com/questions/2066590/automatically-quit-vim-if-nerdtree-is-last-and-only-buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Part3.3 Signify
highlight SignifySignAdd    ctermfg=green  guifg=#00ff00 cterm=NONE gui=NONE
highlight SignifySignDelete ctermfg=red    guifg=#ff0000 cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE
" 空白区域的背景色
highlight SignColumn ctermbg=NONE


" Part3.4 LeaderF
"let g:Lf_ShortcutF = '<c-p>' " TODO 如何有待论证
"let g:Lf_ShortcutB = '<m-n>'
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_UseVersionControlTool = 0
let g:Lf_RootMarkers = ['.vimproject']
let g:Lf_WorkingDirectoryMode = 'AF'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 1
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" Part3.5 nvim-treesitter " TODO 这个插件有待研究
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
ensure_installed = "maintained",

-- Install languages synchronously (only applied to `ensure_installed`)
sync_install = false,

-- List of parsers to ignore installing
ignore_install = { "javascript" },

highlight = {
  -- `false` will disable the whole extension
enable = true,

-- list of language that will be disabled
disable = { "c", "rust" },

-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- Instead of true it can also be a list of languages
additional_vim_regex_highlighting = false,
},
}
EOF

" Part3.6 gutentags
let g:gutentags_project_root = ['.vimproject']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
if !isdirectory(s:vim_tags)
  " 检测 ~/.cache/tags 不存在就新建
  silent! call mkdir(s:vim_tags, 'p')
endif
