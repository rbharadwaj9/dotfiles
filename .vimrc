" Map Leader before installing Plugins. Found this fix from github.com/jbial/dotfiles.
" Doing this later doesn't work. You need to source vimrc everytime you open
" it for them to work.
nnoremap <Space> <Nop>
let mapleader = " "

" Vim PLUG settings
call plug#begin()

" INSERT ALL PLUGS
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-dispatch'
Plug 'kien/ctrlp.vim'

" Themes
Plug 'morhetz/gruvbox'
Plug 'sainnhe/edge'
Plug 'sonph/onehalf', { 'rtp': 'vim' }


" Refactoring with multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Linter
Plug 'w0rp/ale'

" Code Completion
Plug 'maralla/completor.vim'
Plug 'maralla/completor-typescript'

" Bracket Completion
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Syntax Related Plugins
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'cespare/vim-toml'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'mechatroner/rainbow_csv'

" Typescript
Plug 'leafgarland/typescript-vim'

" C++
Plug 'rbharadwaj9/a.vim'

"
Plug 'vim-latex/vim-latex'

" Initialize plugin system
call plug#end()

set statusline+=%{gutentags#statusline()}

" Update linting when exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_linter = {'python':['flake8', 'autopep8'], 'javascript':['xo', 'eslint', 'prettier'], 'cpp':['cppcheck', 'oclint']}
let g:ale_fixers = {'python':['autopep8', 'trim_whitespace', 'isort'], 'html':['tidy'], 'cpp':['clang-format', 'trim_whitespace', 'clangtidy'], 'typescript':['tslint','eslint'], 'javascript':['xo','eslint', 'prettier']}

" Completor Settings
let g:completor_node_binary = '/usr/local/bin/node'

noremap <silent> <leader>c :call completor#do('doc')<CR>
noremap <silent> <leader>d :call completor#do('definition')<CR>
noremap <silent> <leader>s :call completor#do('hover')<CR>

let g:tex_flavor='pdflatex'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }


let g:header_comment_author = "Rajiv"
let g:header_comment_copyright = "(c) Rajiv, 2020, All Rights Reserved."


" Airline Settings
let g:airline#extensions#branch#enabled=1

let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nnoremap <leader>1 <Plug>AirlineSelectTab1
nnoremap <leader>2 <Plug>AirlineSelectTab2
nnoremap <leader>3 <Plug>AirlineSelectTab3
nnoremap <leader>4 <Plug>AirlineSelectTab4
nnoremap <leader>5 <Plug>AirlineSelectTab5
nnoremap <leader>6 <Plug>AirlineSelectTab6
nnoremap <leader>7 <Plug>AirlineSelectTab7
nnoremap <leader>8 <Plug>AirlineSelectTab8
nnoremap <leader>9 <Plug>AirlineSelectTab9

nmap <leader>z :tabedit %<CR>:set nonumber norelativenumber<CR>:set signcolumn=no<CR>"

" Other stuff personalized settings
set number
syntax enable
colorscheme edge
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set autoindent
set cursorline
set laststatus=2
set incsearch
set noshowmode
set title
set foldmethod=indent
set nofoldenable
set showcmd
set completeopt=menuone,noselect,preview
set relativenumber
" highlight ColorColumn ctermbg=magenta

" Autocmds.
augroup file_types
  autocmd FileType cpp,c,typescript,css,scss,less,javascript,json,html,puppet,yaml,jinja.html,vim,vue,groovy setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType html nnoremap <leader>r :!open %<cr>
  autocmd FileType gitcommit,markdown setlocal spell
  autocmd FileType cpp,h,c setlocal colorcolumn=90 foldmethod=syntax foldlevel=1
  autocmd FileType atlas set ft=tasm
augroup END

augroup latex
  autocmd BufWritePost *.tex Dispatch! latexmk -pdf main.tex
augroup END

" Intuitive line scrolling
nnoremap <silent> j gj
nnoremap <silent> k gk

" make Y consistent with C and D.
nnoremap Y y$

" Insert empty line
nmap <leader>o m`o<ESC>``
nmap <leader>O m`O<ESC>``

" Paste block without exitting visual mode
nnoremap <Leader>p pg`[1v

" Disable Command Line history mode.
map q: <Nop>

" ALE specific mappings
nnoremap <silent> <leader>aj :ALENextWrap<cr>
nnoremap <silent> <leader>ak :ALEPreviousWrap<cr>
nnoremap <silent> <leader>aa :ALEFix<cr>

" Replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
