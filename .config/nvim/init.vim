" Map Leader before installing Plugins. Found this fix from github.com/jbial/dotfiles.
" Doing this later doesn't work. You need to source vimrc everytime you open
" it for them to work.
nnoremap <Space> <Nop>
let mapleader = " "

" Vim PLUG settings {{{
call plug#begin()

" INSERT ALL PLUGS
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'ludovicchabant/vim-gutentags'

" Async Makefile make build
Plug 'tpope/vim-dispatch'

" Easy Align
Plug 'junegunn/vim-easy-align'

" Fuzzy Finding
" Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

" Nvim specific
if has('nvim')
  " LSP
  Plug 'neovim/nvim-lspconfig'

  " Completion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'

  " LuaSnip
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
endif

" Themes
Plug 'morhetz/gruvbox'
Plug 'sainnhe/edge'

" " Linter
" Plug 'dense-analysis/ale'

" Doxygen Documentation
Plug 'vim-scripts/DoxygenToolkit.vim'

" " ROS
" Plug 'taketwo/vim-ros'

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

" Writing
Plug 'vim-latex/vim-latex'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

" Initialize plugin system
call plug#end() " }}}

lua require('lsp')

" " ALE Configuration {{{

" " Update linting when exiting insert mode
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1

" let g:ale_linter = {'python':['flake8', 'autopep8'], 'javascript':['xo', 'eslint', 'prettier'], 'cpp':['ccls', 'cppcheck', 'oclint']}
" let g:ale_fixers = {'python':['autopep8', 'trim_whitespace', 'isort'], 'html':['tidy'], 'cpp':['clang-format', 'trim_whitespace', 'clangtidy'], 'typescript':['tslint','eslint'], 'javascript':['xo','eslint', 'prettier']}

" " }}}

let g:tex_flavor='pdflatex'

" let g:ctrlp_custom_ignore = {
"       \ 'dir':  '\.git$\|node_modules\|log\|tmp$',
"       \ 'file': '\.so$\|\.dat$|\.DS_Store$'
"       \ }

" Airline Settings {{{
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
" }}}

" Other stuff personalized settings
set number
syntax enable
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

set statusline+=%{gutentags#statusline()}

" let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
" let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
let &t_8f = "[38;2;%lu;%lu;%lum"
let &t_8b = "[48;2;%lu;%lu;%lum"
set termguicolors

" if exists("$TMUX")
"   set t_Co=256
"   set notermguicolors
" else
" endif

" colo molokai

" The configuration options should be placed before `colorscheme edge`. {{{
" let g:edge_style = 'aura'
" let g:edge_disable_italic_comment = 1
" let g:edge_cursor = 'blue'
" let g:edge_lightline_disable_bold = 1
" let g:edge_better_performance = 1
" set background=dark
" colorscheme edge
" }}}
set background=dark
let g:gruvbox_invert_selection=0
colorscheme gruvbox

" Autocommands {{{
augroup file_types
  autocmd!
  autocmd FileType cpp,c,typescript,css,scss,less,javascript,json,html,puppet,yaml,jinja.html,vim,vue,groovy,bash,zsh setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType html nnoremap <leader>r :!open %<cr>
  autocmd FileType gitcommit,markdown setlocal spell
  autocmd FileType cpp,h,c setlocal colorcolumn=90 foldmethod=syntax foldlevel=1
  autocmd FileType atlas set filetype=tasm
augroup END

augroup filetype_vim
  autocmd! FileType vim setlocal foldmethod=marker
augroup END

augroup latex
  autocmd BufWritePost *.tex Dispatch! latexmk -pdf main.tex
augroup END

" augroup syntax
"   autocmd BufRead,BufNewFile *.launch setfiletype roslaunch
" augroup END

augroup markdown
  " Align Markdown Tables
  autocmd FileType markdown vmap <Leader><Bar> :EasyAlign*<Bar><Enter>
augroup END
" }}}

" goyo.vim for Reading/Writing Mode {{{
augroup GoyoCallbacks
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END 

let g:goyo_height = 100
let g:goyo_width = 100

nnoremap <leader>g :Goyo<cr>
" }}}

" Open current buffer in a new tab without any of the columns for copying
nnoremap <leader>z :tabedit %<CR>:setlocal nonumber norelativenumber<CR>:set signcolumn=no<CR>"

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

" " Disable Command Line history mode.
" map q: <Nop>

" " ALE specific mappings
" nnoremap <silent> <leader>aj :ALENextWrap<cr>
" nnoremap <silent> <leader>ak :ALEPreviousWrap<cr>
" nnoremap <silent> <leader>aa :ALEFix<cr>

" A.vim equivalent with Coc.nvim TODO: CocRequest('clangd',
" 'textDocument/switchSourceHeader', {'uri': 'file://'.expand("%:p")})
autocmd FileType cpp,hpp,h,c nnoremap <leader>AV :vsplit<cr> :CocCommand clangd.switchSourceHeader<cr>

" fzf files
nnoremap <leader>f :Files<cr>
nnoremap <leader>l :Rg<cr>

" Replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" " Catkin Make within a shell
" function CatkinMake()
"     vert term shell -c "echo $CATKIN_WS_ROOT && cd $CATKIN_WS_ROOT && ls" 
" endfunction
