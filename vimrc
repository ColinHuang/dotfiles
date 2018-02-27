" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'rking/ag.vim'

" #Other lang
Plug 'elzr/vim-json'
Plug 'klen/python-mode'
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plug 'fatih/vim-go'
Plug 'avakhov/vim-yaml'
Plug 'moskytw/nginx-contrib-vim'
Plug 'jszakmeister/markdown2ctags'

" #Javascript
" Plug 'jelera/vim-javascript-syntax'
" Plug 'pangloss/vim-javascript'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'burnettk/vim-angular'
Plug 'posva/vim-vue'
Plug 'othree/html5.vim'

" #CSS
Plug 'ap/vim-css-color'
Plug 'groenewege/vim-less'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/csscomplete.vim'

call plug#end()


" ==========================================================================
" General setting
" ==========================================================================
set nocompatible            " Use vim, no vi defaults
syntax on
colorscheme yzlin256_2
set t_Co=256 
highlight ColorColumn ctermbg=233 guibg=#2c2d27

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

:command W w
:command Q q
:command Qa qa
:command Wa wa
:command Wqa wqa
:command WQa wqa

" Buffer fast save
noremap <leader>w :w<CR>
noremap <Leader>q :q!<CR>
noremap <Leader>x :x<CR>
noremap <Leader>z :w<CR><C-Z>
noremap <Leader>!w :w !sudo tee %:p > /dev/null<CR>

" Quick ESC
imap jj <ESC>

" Tired of clearing highlighted searches
nmap <silent> ,/ :nohlsearch<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" ,p: toggle paste mode
noremap <silent> <Leader>p :set paste!<CR>:set paste?<CR> 

" Yank & paste via OS X clipboard
" map <leader>p "*p
" map <leader>y "*y

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

" use ,1 ,2 to go specific tab 
for i in range(1, 9) 
    exec 'nmap <leader>'.i.' '.i.'gt<CR>' 
endfor 

" Q was to go ex mode
" but ex mode is useless to us, so remap it
noremap Q :qa

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

" filetype
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" F-Key
nmap <F2> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
set pastetoggle=<F11>



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
" Automatically quit vim if NERDTree is last and only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif 

" ==========================================================================
" python-mode
" ==========================================================================
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_trim_whitespaces = 1
" let g:pymode_options_colorcolumn = 0
" let g:pymode_doc = 0
autocmd WinEnter * if winnr('$') == 1 && ! empty(&buftype) && ! &modified | quit | endif

" ==========================================================================
" Tagbar
" ==========================================================================
" set focus to TagBar when opening it. Conflict with TagbarOpen setting
" let g:tagbar_autofocus = 0
autocmd BufEnter *.py,*.go,*.md nested TagbarOpen
" autocmd BufEnter *.js,*.css,*.less nested TagbarOpen

" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.vim/bundle/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" ==========================================================================
" YouCompleteMe
" ==========================================================================
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" workaround for tern js: https://github.com/Valloric/YouCompleteMe/issues/570
autocmd FileType javascript setlocal omnifunc=tern#Complete 
autocmd FileType css set omnifunc=csscomplete#CompleteCSS noci

" ==========================================================================
" CtrlP
" ==========================================================================
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules,build     " MacOSX/Linux
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
let g:ctrlp_match_window = 'results:100'

" ==========================================================================
" vim-gitgutter
" ==========================================================================
set signcolumn=yes

" ==========================================================================
" vim-go
" ==========================================================================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" ==========================================================================
" gotags 
" ==========================================================================
" Manually install: https://github.com/jstemmer/gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" ==========================================================================
" airline
" ==========================================================================
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 0

autocmd FileType vue syntax sync fromstart
autocmd BufReadPre *.js let b:javascript_lib_use_vue = 1
