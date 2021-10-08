" Copyright 2021 vimerzhao
"
" Author: vimerzhao
" Email:  vimerzhao@gmail.com
"
" This is my neovim config(which will keep consistent with spacemacs).
" Why not spf-13(which I have used for many years)? No longer maintained.
" Why not SpaceVim? I want my config small and clear(which mean that I know
" every line in my config)
" For more: 
"
" Ref:
"

" Basic Editor Config

set nocompatible " no compatible with Vi

" 开启行号，并使用相对行号
set number relativenumber

" 高亮当前行,并设置下样式
set cursorline
highlight CursorLine cterm=NONE ctermbg=black ctermfg=NONE guibg=NONE guifg=NONE

" 设置编码
set encoding=utf-8 fileencodings=utf-8 termencoding=utf-8

" 在Insert模式下插入，不自动进行Tab缩进
" 注意这个set会重置expandtab，所以必须放在前面
set paste

" 设置Tab规则
set tabstop=4 shiftwidth=4 expandtab autoindent

" 合理的代码会自己控制长度，所以优先考虑不拆行
set nowrap
" 配合nowrap使用，提升超长行的可读性
set sidescrolloff=15
" 上下滚动时，始终和边界保持5行距离，提升可读性
set scrolloff=5

syntax on "开启语法高亮

" 编辑多个文件时，将工作目录自动切换到，正在编辑的文件的目录
set autochdir
" 如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示
set autoread

" Ref: http://yyq123.blogspot.com/2011/11/vim-listchars.html
set list "突出显示不可见字符
set listchars=tab:»■,precedes:«,extends:»,trail:■ "eol:换行符 / space:空格

" 开始配置插件，使用vim-plug管理（Vundle已经不维护了）

" Ref: https://www.cnblogs.com/cniwoq/p/13272746.html
" TODO 后续还要多每个插件深入了解，进行更合理的配置
call plug#begin('~/.vim/plugged')
Plug 'Yggdroot/indentLine' " 提供一个可视化的缩进

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' "airline 的主题

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()


" 插件配置
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进
