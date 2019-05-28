" Vim PLUG settings
call plug#begin()

" INSERT ALL PLUGS
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'maralla/completor.vim'

" Initialize plugin system
call plug#end()


" Update linting when exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_linter = {'python':['flake8', 'autopep8']}
let g:ale_fixers = {'python':['autopep8', 'prettier']}
"let g:ale_completion_enabled = 1

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


" Keybindings

