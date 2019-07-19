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
Plug 'pangloss/vim-javascript'

" Initialize plugin system
call plug#end()

" Update linting when exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_linter = {'python':['flake8', 'autopep8'], 'javascript':['eslint', 'prettier']}
let g:ale_fixers = {'python':['autopep8', 'trim_whitespace', 'isort'], 'html':['tidy'], 'cpp':['clang-format']}

" Completor Settings
let g:completor_node_binary = '/usr/local/bin/node'

let g:completor_complete_options = 'menuone,noselect,preview'
noremap <silent> <leader>c :call completor#do('doc')<CR>
noremap <silent> <leader>d :call completor#do('definition')<CR>
noremap <silent> <leader>s :call completor#do('hover')<CR>

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

nmap <leader>z :tabedit %<CR>:set nonumber<CR>:set signcolumn=no<CR>"

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

" Autocmds.
autocmd FileType css,less,javascript,json,html,puppet,yaml,jinja.html,vim,vue setlocal shiftwidth=2 tabstop=2 softtabstop=2 
autocmd FileType html nmap <leader>r :!open %<cr>
autocmd FileType gitcommit,markdown setlocal spell

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

" nmap <silent> <C-l> <C-w><C-l><cr>
" nmap <silent> <C-k> <C-w><C-k><cr>
" nmap <silent> <C-j> <C-w><C-j><cr>
" nmap <silent> <C-h> <C-w><C-h><cr>

" Replace word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
