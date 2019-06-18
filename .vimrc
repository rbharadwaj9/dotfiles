" Vim PLUG settings
call plug#begin()

" INSERT ALL PLUGS
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'

" Linter
Plug 'w0rp/ale'

" Code Completion
Plug 'maralla/completor.vim'

" Bracket Completion
Plug 'jiangmiao/auto-pairs'

" Syntax Related Plugins
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'cespare/vim-toml'
Plug 'octol/vim-cpp-enhanced-highlight'

" Initialize plugin system
call plug#end()


" Update linting when exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_linter = {'python':['flake8', 'autopep8']}
let g:ale_fixers = {'python':['autopep8', 'trim_whitespace', 'isort'], 'html':['tidy'], 'cpp':['clang-format']}

" Airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled=1

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

" Autocmds.
autocmd FileType css,less,javascript,json,html,puppet,yaml,jinja.html,vim,vue setlocal shiftwidth=2 tabstop=2 softtabstop=2 
autocmd FileType html nmap <leader>r :!open %<cr>
autocmd FileType gitcommit markdown setlocal spell

" Keybindings
nnoremap <Space> <Nop>
let mapleader = " "

" Intuitive line scrolling
nnoremap <silent> j gj
nnoremap <silent> k gk

" make Y consistent with C and D.
nnoremap Y y$

" Insert empty line
nmap <leader>o m`o<ESC>``
nmap <leader>O m`O<ESC>``

" Disable Command Line history mode.
map q: <Nop>

" ALE specific mappings
nmap <silent> <leader>aj :ALENextWrap<cr>
nmap <silent> <leader>ak :ALEPreviousWrap<cr>
nmap <silent> <leader>aa :ALEFix<cr>
