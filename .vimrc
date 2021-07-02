set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'ap/vim-css-color'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'

call vundle#end()

nnoremap <C-t> :NERDTreeToggle<CR>


if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
  
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.colnr = ':'
let g:airline_symbols.linenr = '☰ '


let g:airline_powerline_fonts = 1

set exrc
set secure

set number	
set linebreak
set showbreak=+++
set textwidth=100
set showmatch

syntax on

set hlsearch	
set smartcase	
set ignorecase	
set incsearch	
 
filetype plugin indent on

set autoindent	
set shiftwidth=4
set smartindent	
set smarttab
set softtabstop=4	
 
set ruler	
set showcmd
 
set undolevels=1000
set backspace=indent,eol,start	
set encoding=UTF-8

colorscheme nord
