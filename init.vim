" Copyright 2021 vimerzhao
"
" Author: vimerzhao
" Email:  vimerzhao@gmail.com
"
" 一、 为什么要维护这份配置
"
" 是否可以让部分配置延迟加载

" https://vim.rtorr.com/
" =============================================================================
"                       Part1: 基础配置
" =============================================================================

" no compatible with Vi
set nocompatible

set number relativenumber
" https://www.ditig.com/256-colors-cheat-sheet
highlight Normal cterm=NONE ctermbg=234 ctermfg=NONE guibg=NONE guifg=NONE
highlight LineNr cterm=NONE ctermbg=233 ctermfg=grey guibg=NONE guifg=NONE
set cursorline
highlight CursorLine cterm=NONE ctermbg=232 ctermfg=NONE guibg=NONE guifg=NONE
highlight Visual cterm=NONE ctermbg=1 ctermfg=NONE guibg=NONE guifg=NONE

" 配置弹出框的样式
highlight PMenu ctermfg=34 ctermbg=238 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=40 ctermbg=244 guifg=darkgrey guibg=black
highlight SignColumn ctermbg=234
" 底部信息栏/命令输入框的高度，默认1
" set cmdheight=2

" 优化光标显示，Work Good For Me(Tmux + Terminal on Mac OS)
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" From coc.nvim
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  "set signcolumn=number
else
  "set signcolumn=yes
endif

set autowrite

set encoding=utf-8 fileencodings=utf-8 termencoding=utf-8
" set noic / set noignorecase
set ignorecase

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

" 进入Vim和离开InsertMode时，都自动切换到英文输入法
" TODO 可以更智能，记录之前的输入法
autocmd VimEnter,InsertLeave * silent! :!im-select 'com.apple.keylayout.ABC'


" =============================================================================
"                       Part2: Leader配置
" =============================================================================
" 基本原则：
"   1. 使用频率越高，触发路径越容易
"   2. Spacemacs在用快捷键，尽量保持一致
"
" 命名参考：
"   a -> ale 相关
"   c -> coc.nvim 相关
"   f -> file, 文件操作 / LeaderF相关操作
"   F -> Function
"   w -> window, 窗口操作
" https://stackoverflow.com/questions/446269/can-i-use-space-as-mapleader-in-vim
map <Space> <Leader>
" Part2.1文件管理器
nnoremap <leader>ft :NERDTreeToggle<CR>

" Part2.2 窗口操作
nmap <Leader>w <C-w>
nmap <Leader>w- :split<CR>
nmap <Leader>w/ :vsplit<CR>
nmap <Leader><Up> :resize +2<CR>
nmap <Leader><Down> :resize -2<CR>
nmap <Leader><Left> :vertical resize +2<CR>
nmap <Leader><Right> :vertical resize -2<CR>

" LeaderF
" Ref: https://retzzz.github.io/dc9af5aa/
noremap <Leader>fm :Leaderf mru<cr>
noremap <Leader>ff :Leaderf file<cr>
noremap <Leader>fw :Leaderf window<cr>
noremap <Leader>fb :Leaderf bufTag<cr>

nmap <unique> <leader>fr <Plug>LeaderfRgPrompt
nmap <unique> <leader>fra <Plug>LeaderfRgCwordLiteralNoBoundary
nmap <unique> <leader>frb <Plug>LeaderfRgCwordLiteralBoundary
nmap <unique> <leader>frc <Plug>LeaderfRgCwordRegexNoBoundary
nmap <unique> <leader>frd <Plug>LeaderfRgCwordRegexBoundary

vmap <unique> <leader>fra <Plug>LeaderfRgVisualLiteralNoBoundary
vmap <unique> <leader>frb <Plug>LeaderfRgVisualLiteralBoundary
vmap <unique> <leader>frc <Plug>LeaderfRgVisualRegexNoBoundary
vmap <unique> <leader>frd <Plug>LeaderfRgVisualRegexBoundary

" My Custom Command
noremap <Leader>vc :cclose<cr>

" Reft: https://clang.llvm.org/docs/ClangFormat.html
" This is a basic and simple intergration. Need to improve:
" Ref: https://github.com/vim-autoformat/vim-autoformat
" Note: <silent> should be after vmap if needed
if has('python3')
  vmap <Leader>vf :py3f ~/.config/nvim/tools/clang-format.py<cr>
  " https://vim.fandom.com/wiki/Use_Ctrl-O_instead_of_Esc_in_insert_mode_mappings
  " imap <C-I> <c-o>:pyf <path-to-this-file>/clang-format.py<cr>
endif
noremap <Leader>vo :copen<cr>
function! RunProject()
  let $VIM_RUN_SCRIPT_PATH = findfile('.vimproject/run.sh', ';')
  :AsyncRun echo ${VIM_RUN_SCRIPT_PATH} && sh ${VIM_RUN_SCRIPT_PATH}
endfunction
noremap <Leader>vr :call RunProject()<cr>


" noremap <Leader>vC :call CleanProject()<cr>


" coc.nvim

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
Plug 'dense-analysis/ale'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

Plug 'skywind3000/asyncrun.vim'
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
highlight SignifySignAdd    ctermfg=green  ctermbg=234 guifg=#00ff00 cterm=NONE gui=NONE
highlight SignifySignDelete ctermfg=red  ctermbg=234  guifg=#ff0000 cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=yellow ctermbg=234 guifg=#ffff00 cterm=NONE gui=NONE


" Part3.4 LeaderF
"let g:Lf_ShortcutF = '<c-p>' " TODO 如何有待论证
"let g:Lf_ShortcutB = '<m-n>'
" echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
let g:Lf_UseVersionControlTool = 0
let g:Lf_RecurseSubmodules = 1
let g:Lf_RootMarkers = ['.vimproject']
let g:Lf_WorkingDirectoryMode = 'AF'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 1
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_PreviewInPopup = 1
" https://github.com/Yggdroot/LeaderF/issues/567
let g:Lf_ShowDevIcons = 0

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

" coc.nvim
" From https://github.com/neoclide/coc.nvim#example-vim-configuration
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>cp  :<C-u>CocListResume<CR>



" -------------------------------------------------------------------------------------------------
"  ALE
" -------------------------------------------------------------------------------------------------
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_column_always = 1
let g:ale_set_highlights = 1
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[ALE] [%linter%] %s [%severity%]'
"打开文件时不进行检查
let g:ale_lint_on_enter = 0
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>at :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>ad :ALEDetail<CR>
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
\   'cpp' : ['clang++', 'clangd'],
\   'c': ['clang'],
\   'python': ['pylint'],
\}

