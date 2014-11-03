" ==========================================================================
" Vundle
" Brief help:
" $ PluginList - list configured bundles
" $ PluginInstall(!) - install (update) bundles
" $ PluginSearch(!) foo - search (or refresh cache first) for foo
" $ PluginClean(!) - confirm (or auto-approve) removal of unused bundles
" ==========================================================================
set nocompatible             " be improved, required
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
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'klen/python-mode'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'elzr/vim-json'
Plugin 'tomtom/tcomment_vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'honza/dockerfile.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" L9
" FuzzyFinder
" vim-snipnate
" mru
" mileszs/ack.vim

" ==========================================================================
" General setting
" ==========================================================================
set nocompatible            " Use vim, no vi defaults
colorscheme yzlin256_2
set t_Co=256 
"let &colorcolumn=join(range(81,999),",")
"highlight ColorColumn ctermbg=235 guibg=#2c2d27

set nobackup
set nowritebackup
set noswapfile  
set cursorline
set number
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,big5,utf8
set history=50	" keep 50 lines of command line history
set laststatus=2" Displaying status line always
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set autoread    " Set to auto read when a file is changed from the outside
set mouse=a
syntax on

" Tabs and spaces handling
set smarttab               " Uses shiftwidth instead of tabstop at start of lines
set expandtab              " Replaces a <TAB> with spaces--more portable
set tabstop=4              " 4 space tab
set shiftwidth=4           " The amount to block indent when using < and >
set softtabstop=4          " Makes the spaces feel like real tabs
set backspace=indent,eol,start  " allow backspacing over everything in insert mode

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" No show command
autocmd VimEnter * set nosc

" ==========================================================================
" Custom Mappings
" ==========================================================================
let mapleader=","

" Buffer fast save
nmap <leader>w :w<cr>

" Quick ESC
imap jj <ESC>

" Tired of clearing highlighted searches
nmap <silent> ,/ :nohlsearch<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Yank & paste via OS X clipboard
map <leader>p "*p
map <leader>y "*y

" Move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap gj j
nnoremap gk k

" Format the entire file
nmap <leader>fef ggVG=

" Move around splits window with <c-hjkl>
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-h> <c-w>h
" nnoremap <c-l> <c-w>l

" Tab between windows
noremap <tab> <c-w><c-w>

" Switch/create tab(s) in quick - Really handy!
" Conflict with move around splits
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-t> :tabnew<CR>
map <C-w> :tabclose<CR>

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" TODO and FIXME list in vim
command Todo noautocmd vimgrep /TODO\|FIXME/j * | cw
"command Todo Ack! 'TODO\|FIXME' " If use the ack-vim plugin

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on " Enable file type detection.
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent " always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


if ! has('gui')
  highlight Comment ctermfg=gray ctermbg=darkblue
endif


" ==========================================================================
" NERDTree
" ==========================================================================
" let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
map <F2> :NERDTreeToggle<CR>
" Automatically quit vim if NERDTree is last and only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif 

" ==========================================================================
" python-mode
" ==========================================================================
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_options_colorcolumn = 0
autocmd WinEnter * if winnr('$') == 1 && ! empty(&buftype) && ! &modified | quit | endif

" ==========================================================================
" Tagbar
" ==========================================================================
nmap <F8> :TagbarToggle<CR>
" set focus to TagBar when opening it. Conflict with TagbarOpen setting
" let g:tagbar_autofocus = 0
autocmd BufEnter *.py nested TagbarOpen

" ==========================================================================
" YouCompleteMe
" ==========================================================================
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ==========================================================================
" CtrlP
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

" ==========================================================================
" vim-gitgutter
" ==========================================================================
" highlight clear SignColumn
highlight SignColumn ctermbg=233
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_column_always = 1 
