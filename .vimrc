call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'ap/vim-css-color'

call plug#end()

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

colorscheme nord
