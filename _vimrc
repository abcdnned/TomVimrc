set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=$HOME/vimfiles/bundle/Vundle.vim
call vundle#begin('$HOME/vimfiles/bundle/')
Plugin 'VundleVim/Vundle.vim'
Plugin 'kkoenig/wimproved.vim'
call vundle#end()            " required
filetype plugin indent on    " required

set nu

let $LANG='en'
set langmenu=en
set directory=.,$TEMP
winpos 10 10
set lines=30 columns=120 
colo evening 
set autoindent

let mapleader="\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>p :!python %<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>b :b <c-d>
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>r :e $VIMRC<CR>

"fullscreen setting
autocmd GUIEnter * silent! WToggleClean
autocmd GUIEnter * WToggleFullscreen
autocmd GUIEnter * WSetAlpha 200
autocmd VIMEnter * cd $WS

set tabstop=4
set shiftwidth=4
set expandtab

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


set encoding=utf-8
set fileencoding=utf-8

set guioptions-=r
set guioptions-=T
set guioptions-=m
set guioptions-=b
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
