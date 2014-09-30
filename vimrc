
" ===========================================================================
" Vundle
" Brief help:
" $ PluginList - list configured bundles
" $ PluginInstall(!) - install (update) bundles
" $ PluginSearch(!) foo - search (or refresh cache first) for foo
" $ PluginClean(!) - confirm (or auto-approve) removal of unused bundles
" ===========================================================================
set nocompatible             " be iMproved, required
filetype off                 " required

" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" My plugins here:
"
" original repos on github
Plugin 'Lokaltog/vim-powerline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'klen/python-mode'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'elzr/vim-json'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" L9
" FuzzyFinder
" vim-snipnate
" ack
" mru
" supertab


" ===========================================================================
" General setting
" ===========================================================================
colorscheme yzlin256_2
set t_Co=256 
"let &colorcolumn=join(range(81,999),",")
"highlight ColorColumn ctermbg=235 guibg=#2c2d27


set nobackup
set nowb  
set noswapfile  
set cursorline


set nu

set fileencoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,big5,utf8

" tabs and spaces handling
set smarttab               "Uses shiftwidth instead of tabstop at start of lines
set expandtab              "Replaces a <TAB> with spaces--more portable
set tabstop=4              "4 space tab
set shiftwidth=4           "The amount to block indent when using < and >
set softtabstop=4          " Makes the spaces feel like real tabs
set backspace=indent,eol,start


" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set autoread    " Set to auto read when a file is changed from the outside

" Move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap gj j
nnoremap gk k

let mapleader=","

 " Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

set mouse=a	" Enable mouse usage (all modes)  

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif



if ! has('gui')
  highlight Comment ctermfg=gray ctermbg=darkblue
endif


" tagbar
nmap <F8> :TagbarToggle<CR>
" set focus to TagBar when opening it
"let g:tagbar_autofocus = 1

" ===========================================================================
" NERDTree
" ===========================================================================
"let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
"let NERDTreeSortOrder=['^__\.py$', '\/$', '\.py$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
map <F2> :NERDTreeToggle<CR>
" Automatically quit vim if NERDTree is last and only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif 

" ===========================================================================
" python-mode
" ===========================================================================
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_trim_whitespaces = 1
" let g:pymode_lint_on_write = 0
" let g:pymode_lint_signs = 0
autocmd BufRead *.py setlocal colorcolumn=0

" Tagbar -----------------------------  
" toggle tagbar display 
map <F4> :TagbarToggle<CR> 
" autofocus on tagbar open 
let g:tagbar_autofocus = 1 
" Assuming the pylint window shows a scratch buffer, you can close this automatically
autocmd WinEnter * if winnr('$') == 1 && ! empty(&buftype) && ! &modified | quit | endi

" ==========================================================================
" Powerline setup
" ==========================================================================
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" ==========================================================================
" YouCompleteMe
" ==========================================================================
let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_register_as_syntastic_checker = 0
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ==========================================================================
"CtrlP
" ==========================================================================
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules,build     " MacOSX/Linux

let g:ctrlp_by_filename = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|tmp)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
    \ 'fallback': 'find %s -type f'
    \ }
