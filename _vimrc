set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=$HOME/vimfiles/bundle/Vundle.vim
call vundle#begin('$HOME/vimfiles/bundle/')
Plugin 'VundleVim/Vundle.vim'
Plugin 'kkoenig/wimproved.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()            " required
filetype plugin indent on    " required
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories=["C:/Users/chen/snips","C:/Users/chen/vimfiles/bundle/vim-snippets/UltiSnips"]

set nu

let $LANG='en'
set langmenu=en
set directory=.,$TEMP
winpos 10 10
set lines=30 columns=120 
colo evening 
set autoindent

set autowrite

" user command "
command -range Pyacom :<line1>,<line2>s/^/#/  " python add comments
command -range Pydcom :<line1>,<line2>s/#//  " python delete comments

command -range=% DeletePrint :<line1>,<line2>g/\<print\>/d " delete all lines which contains print

set autoread

let mapleader="\<Space>"
noremap <Leader>w :w<CR>
noremap <Leader>p :!python %<CR>
noremap <Leader>e :e 
noremap <Leader>n :bnext<CR>
noremap <Leader>N :bprevious<CR>
noremap <Leader>r :e $VIMRC<CR>
noremap <Leader>f :WToggleFullscreen<CR>

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
