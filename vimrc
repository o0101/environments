" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
"syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Cris' settings for vim now global for everyone
colorscheme blue
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set foldmethod=indent
nnoremap <Space> za

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/undodir')
  " Create dirs
  call system('mkdir ' . vimDir)
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif

set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set viminfo='100,<1000,s100,h

noremap <C-Q> <C-V>
set mouse-=a
set laststatus=2
set ruler

au BufRead,BufNewFile Makefile,makefile,GNUmakefile set filetype=make
augroup Makefile
  autocmd!
  autocmd FileType make setlocal noexpandtab
augroup END

" Encoding settings: UTF-8 default, conditional BOM for .ps1 with Unicode
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set fileencoding=utf-8  " Default to UTF-8 without BOM

" Function to check for Unicode (non-ASCII) characters
function! HasUnicode()
  return search('[^\x00-\x7F]', 'n') > 0
endfunction

" Apply BOM to .ps1 files only if Unicode is present
autocmd BufNewFile,BufWrite *.ps1 if HasUnicode() | set bomb | else | set nobomb | endif
autocmd BufNewFile,BufWrite *.ps1 set fileencoding=utf-8

" Dynamic statusline with time and encoding
function! UpdateStatusLine(timer)
  let time = strftime('%c')
  let enc = (&fenc != '' ? &fenc : &enc) . (exists('+bomb') && &bomb ? ',bom' : '')
  let &statusline = '%f %h%w%m%r [' . time . '] %= [' . enc . '] %-14.(%l,%c%V%) %P'
endfunction
set statusline=%f\ %h%w%m%r\ [%{strftime('%c')}]%=\ [%{&fenc!=''?&fenc:&enc}%{exists('+bomb')&&&bomb?',bom':''}]\ %-14.(%l,%c%V%)\ %P
call timer_start(500, 'UpdateStatusLine', {'repeat': -1})
