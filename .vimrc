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
Plug 'tpope/vim-dispatch'

" Fuzzy Finding
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

" Themes
Plug 'morhetz/gruvbox'
Plug 'sainnhe/edge'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Refactoring with multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Linter
Plug 'dense-analysis/ale'

" Code Completion
" Plug 'maralla/completor.vim'
" Plug 'maralla/completor-typescript'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" ALE Configuration {{{

" Update linting when exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_linter = {'python':['flake8', 'autopep8'], 'javascript':['xo', 'eslint', 'prettier'], 'cpp':['ccls', 'cppcheck', 'oclint']}
let g:ale_fixers = {'python':['autopep8', 'trim_whitespace', 'isort'], 'html':['tidy'], 'cpp':['clang-format', 'trim_whitespace', 'clangtidy'], 'typescript':['tslint','eslint'], 'javascript':['xo','eslint', 'prettier']}

" }}}

" COC Configuration {{{
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
inoremap <silent><expr> <c-space> coc#refresh()
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
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
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
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}

" Completor Settings {{{
let g:completor_node_binary = '/usr/local/bin/node'

noremap <silent> <leader>c :call completor#do('doc')<CR>
noremap <silent> <leader>d :call completor#do('definition')<CR>
noremap <silent> <leader>s :call completor#do('hover')<CR>

let g:tex_flavor='pdflatex'

let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|node_modules\|log\|tmp$',
      \ 'file': '\.so$\|\.dat$|\.DS_Store$'
      \ }
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

augroup syntax
  autocmd BufRead,BufNewFile *.launch setfiletype roslaunch
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

" Disable Command Line history mode.
map q: <Nop>

" ALE specific mappings
nnoremap <silent> <leader>aj :ALENextWrap<cr>
nnoremap <silent> <leader>ak :ALEPreviousWrap<cr>
nnoremap <silent> <leader>aa :ALEFix<cr>

" Replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
