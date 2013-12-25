set nocompatible
set encoding=utf-8

set expandtab
set cursorline
set history=500

" Syntax
call pathogen#infect()
syntax on
filetype plugin indent on

autocmd FileType ruby setlocal tabstop=3 softtabstop=3 shiftwidth=3

set t_Co=256
colorscheme molokai
