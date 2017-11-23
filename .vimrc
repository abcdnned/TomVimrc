set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin('$HOME/.vim/bundle/')
Plugin 'VundleVim/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ervandew/supertab'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'iwataka/airnote.vim'
Plugin 'mihaifm/bufstop'
Plugin 'Dinduks/vim-java-get-set'
Plugin 'vim-scripts/DrawIt'
Plugin 'scrooloose/nerdcommenter'
Plugin 'abcdnned/vim-java-manager'
Plugin 'abcdnned/vim-java-commenter'
Plugin 'derekwyatt/vim-scala'
Plugin 'othree/html5.vim'
Plugin 'abcdnned/maven-compiler.vim'
Plugin 'akhaku/vim-java-unused-imports'
Plugin 'abcdnned/vim-hide-show'
Plugin 'abcdnned/vim-string-search'
Plugin 'abcdnned/vim-playchips'
Plugin 'arecarn/vim-selection'
Plugin 'arecarn/vim-crunch'
Plugin 'katono/rogue.vim'
Plugin 'uguu-org/vim-matrix-screensaver'
Plugin 'abcdnned/vim-random'
Plugin 'abcdnned/vim-java-extractor'
"Plugin 'bling/vim-bufferline'
"Plugin 'vim-scripts/showhide.vim'
"Plugin 'vim-polyglot'
"Plugin 'vim-scripts/jcommenter.vim'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'jvenant/vim-java-imports'

call vundle#end()            " required
filetype plugin indent on    " required


syntax on

set hlsearch
set nowrapscan

" maven compiler configuration
auto Filetype java compiler mvn
auto Filetype pom compiler mvn

" supertab configuration
let g:SuperTabDefaultCompletionType = "context"

" jedi-vim configuration
"let g:jedi#popup_on_dot = 0
"let g:jedi#completions_command = <c-n>"
"let g:jedi#rename_command="<leader>pr"

" customer leader
let mapleader="\<Space>"


" Trigger configuration. Do not use <Tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = "<c-\\>"
let g:UltiSnipsJumpForwardTrigger = "<c-\\>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-Tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsSnippetDirectories=["/home/tom/gitrepo/tomsnips","/home/tom/gitrepo/tomsnips/netissnips","/home/tom/.vim/bundle/vim-snippets/UltiSnips"]

"polyglot configuration
"let g:polyglot_disabled = ['scala']

"bufstop configuration
let g:BufstopAutoSpeedToggle = 1

"ctrlp configuration
let g:ctrlp_working_path_mode = 0

"vim-airline configuration
set laststatus=2
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme='molokai'
let g:airline_section_c=''
let g:airline_section_error=''
let g:airline_section_warning=''

"bufferline configuration
let g:bufferline_rotate = 1
let g:bufferline_echo = 0


"airnote configuration
let g:airnote_path = expand('$HOME/gitrepo/tomsnips/note')
let g:airnote_suffix = ''
let g:airnote_date_format = ''


set nu

let $LANG='en'
set langmenu=en
set directory=.,$TEMP
set autoindent
set autowrite
let g:netrw_preview=1

" user command "
cabbr <expr> %% expand("%:p:h")

command -range=% DeletePrint :<line1>,<line2>g/\<print\>/d " delete all lines which contains print

set autoread

noremap <leader>m :CtrlPMRUFiles<CR>

"remove all hightlight
nnoremap <silent> <leader>hc /pleasedisablehighlightthanks<CR>

"open writedown file when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | e $HOME/gitrepo/pyws/writedown | endif

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start

set encoding=utf-8
set fileencoding=utf-8


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

command -nargs=* SeqThis :call SeqThis(<f-args>)

function SeqThis(...)
let n = line('.')
let l = getline(n) 
let j = 0
for i in range(a:1,a:2) 
    let nl = substitute(l,'1',i,'g')
    call append(n+j,nl)
    let j += 1
endfor
endfunction 

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
