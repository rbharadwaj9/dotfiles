set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if has('nvim')
  Plug 'jbyuki/nabla.nvim'
endif
