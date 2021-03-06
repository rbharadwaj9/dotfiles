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

let g:ale_linter = {'python':['flake8', 'autopep8'], 'javascript':['eslint', 'prettier'], 'cpp':['cppcheck', 'oclint']}
let g:ale_fixers = {'python':['autopep8', 'trim_whitespace', 'isort'], 'html':['tidy'], 'cpp':['clang-format', 'trim_whitespace', 'clangtidy'], 'typescript':['tslint','eslint']}

" Completor Settings
let g:completor_node_binary = '/usr/local/bin/node'

noremap <silent> <leader>c :call completor#do('doc')<CR>
noremap <silent> <leader>d :call completor#do('definition')<CR>
noremap <silent> <leader>s :call completor#do('hover')<CR>

let g:tex_flavor='pdflatex'


" Airline Settings
let g:airline#extensions#branch#enabled=1

let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

nmap <leader>z :tabedit %<CR>:set nonumber norelativenumber<CR>:set signcolumn=no<CR>"

" Other stuff personalized settings
set number
syntax enable 
colorscheme molokai 
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
autocmd FileType typescript,css,scss,less,javascript,json,html,puppet,yaml,jinja.html,vim,vue setlocal shiftwidth=2 tabstop=2 softtabstop=2 
autocmd FileType html nmap <leader>r :!open %<cr>
autocmd FileType gitcommit,markdown setlocal spell
autocmd FileType cpp,h,c set colorcolumn=90 foldmethod=syntax foldlevel=1
" autocmd FileType cpp let w:m2=matchadd('ColorColumn', '\%>80v.\+', 100)
autocmd BufWritePost *.tex Dispatch! latexmk -pdf main.tex
autocmd FileType atlas set ft=tasm

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
nmap <silent> <leader>aj :ALENextWrap<cr>
nmap <silent> <leader>ak :ALEPreviousWrap<cr>
nmap <silent> <leader>aa :ALEFix<cr>

" Replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
