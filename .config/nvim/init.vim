" Map Leader before installing Plugins. Found this fix from github.com/jbial/dotfiles.
" Doing this later doesn't work. You need to source vimrc everytime you open
" it for them to work.
nnoremap <Space> <Nop>
let mapleader = " "

" Vim PLUG settings {{{
call plug#begin()

" INSERT ALL PLUGS
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'ludovicchabant/vim-gutentags'

" Nvim specific
if has('nvim')

  Plug 'nvim-lua/plenary.nvim'

  " Statusline
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'akinsho/bufferline.nvim'

  " Winbar
  Plug 'fgheng/winbar.nvim'

  " Mason for ease of use with external tooling
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'

  " Formatting
  Plug 'mhartington/formatter.nvim'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'mfussenegger/nvim-jdtls' " Java
  Plug 'j-hui/fidget.nvim' " Showing LSP status in the bottom right
  Plug 'wiliamks/nice-reference.nvim' " Fetching LSP References

  " Completion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'

  " LuaSnip
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'

  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'

  " Telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  " Tree
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons'

  " Code Context
  Plug 'SmiteshP/nvim-navic'

  " Oil Nvim
  Plug 'stevearc/oil.nvim'

  " Debugging
  Plug 'mfussenegger/nvim-dap-python' " Python uses debugpy from Mason
  Plug 'mfussenegger/nvim-dap'
  Plug 'theHamsta/nvim-dap-virtual-text'

else
  " Only for Vim
  Plug 'vim-airline/vim-airline'

  " Fuzzy Finding
  " Plug 'kien/ctrlp.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
  Plug 'junegunn/fzf.vim'

endif

" Common between Nvim and Vim

" Themes
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'nlknguyen/papercolor-theme'
Plug 'rbharadwaj9/vim-vscode-theme'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rebelot/kanagawa.nvim'

" Async Makefile make build
Plug 'tpope/vim-dispatch'

" Easy Align
Plug 'junegunn/vim-easy-align'

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

if has('nvim')
    lua require('init')
endif

" Vim Specific Settings
if !has('nvim')

" FZF Config {{{
" Use Ag to exclude gitignore files in fuzzy search
if executable("ag")
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

nnoremap <leader>f :Files<cr>
nnoremap <leader>gf :GitFiles<cr>
nnoremap <leader>l :Rg<cr>
" let g:ctrlp_custom_ignore = {
"       \ 'dir':  '\.git$\|node_modules\|log\|tmp$',
"       \ 'file': '\.so$\|\.dat$|\.DS_Store$'
"       \ }
" }}}

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

endif

let g:tex_flavor='pdflatex'

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
set nohlsearch

" Disable Mouse
set mouse=

" set statusline+=%{gutentags#statusline()}

let g:gutentags_enabled = 0

set termguicolors

colorscheme kanagawa

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

" Replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>


" The line beneath this is called `modeline`. See `:help modeline`
" vim: ts=2 sts=2 sw=2 et
