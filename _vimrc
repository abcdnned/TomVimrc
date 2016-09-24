set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=$HOME/vimfiles/bundle/Vundle.vim
call vundle#begin('$HOME/vimfiles/bundle/')
Plugin 'VundleVim/Vundle.vim'
Plugin 'kkoenig/wimproved.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-polyglot'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ervandew/supertab'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'fs111/pydoc.vim'
Plugin 'tpope/vim-surround'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

call vundle#end()            " required
filetype plugin indent on    " required


syntax on


" customer leader
let mapleader="\<Space>"

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = "<c-s>"
let g:UltiSnipsJumpForwardTrigger = "<c-s>"
let g:UltiSnipsJumpBackwardTrigger = "<c-w>"
let g:UltiSnipsListSnippets="<c-l>"

let g:UltiSnipsSnippetDirectories=["C:/gitrepo/tomsnips","c:/gitrepo/tomsnips/note","bundle/vim-snippets/UltiSnips"]
let g:polyglot_disabled = ['python']



"vim-airline configuration
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='molokai'

"bufferline configuration
let g:bufferline_rotate = 1

"pydoc configuration
let g:pydoc_cmd = "C:/Python27/Lib/pydoc.py"

"Wimproved configuration
autocmd GUIEnter * silent! WToggleClean
autocmd GUIEnter * WToggleFullscreen
autocmd GUIEnter * WSetAlpha 200
autocmd VIMEnter * cd $WS
noremap <Leader>f :WToggleFullscreen<CR>

"vim-notes configuration
let g:notes_directories = ['C:\gitrepo\tomsnips\note']


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


noremap <Leader>w :w<CR>
noremap <Leader>e :w \| e 
noremap <Leader>n :bnext<CR>
noremap <Leader>N :bprevious<CR>
noremap <Leader>q :q<CR>
noremap <Leader>r :e $VIMRC<CR>

noremap <CR> o<ESC>k
noremap <S-Enter> O<ESC>j


"open writedown file when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | e $WS/writedown | endif

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