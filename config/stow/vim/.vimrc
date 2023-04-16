" Don't try to be vi compatible
set nocompatible

" -----------------------------------------------------------------------------
" Plugins

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'ghifarit53/tokyonight-vim'

Plugin 'itchyny/lightline.vim'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Plugin 'ludovicchabant/vim-gutentags'
" Plugin 'preservim/tagbar'

Plugin 'airblade/vim-gitgutter'

Plugin 'tpope/vim-commentary'

" Plugin 'mbbill/undotree'

" Plugin 'sheerun/vim-polyglot'

Plugin 'preservim/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'moll/vim-bbye'

" Plugin 'prabirshrestha/vim-lsp'
" Plugin 'mattn/vim-lsp-settings'

call vundle#end()

" For plugins to load correctly
filetype plugin indent on

" -----------------------------------------------------------------------------
" Vim basics

" Security
set modelines=0

" Encoding
set encoding=utf-8

" Rendering
set ttyfast

" Allow hidden buffers
set hidden

" -----------------------------------------------------------------------------
" User interaction

" Split new panes to the right
set splitright

" Blink cursor on error instead of beeping (grr)
set visualbell

" Enable the mouse
set mouse=a

" -----------------------------------------------------------------------------
" Key mapping (non-plugin)

let mapleader = ","

map <C-c> <Esc>
map! <C-c> <Esc>

" Buffer navigation
:nnoremap <Leader>d :Bdelete<CR>
:nnoremap <Leader>j :bprevious<CR>
:nnoremap <Leader>k :bnext<CR>

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Move stuff around in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Yank to system clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p

" Formatting
map <leader>q gqip

" No Ex mode..
noremap Q <nop>

" Searching
nnoremap / /\c
vnoremap / /\c
nnoremap <c-n> nzz
nnoremap <c-N> Nzz
map <leader><space> :let @/=''<cr> " clear search

" Replace in file
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" -----------------------------------------------------------------------------
" Command abbreviations

cnoreabbrev h vert h
cnoreabbrev help vert help

" -----------------------------------------------------------------------------
" Code look and feel

syntax on

" Page width
set nowrap
set textwidth=80
set colorcolumn=80

" Line numbering
set number

" Whitespace
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=12
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Use thin cursor for input mode
let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"

" Last line
set showmode
set showcmd
set laststatus=2

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set shortmess-=S

" Comment style
autocmd FileType c,cpp setlocal commentstring=//\ %s

" -----------------------------------------------------------------------------
" Filetypes

autocmd BufEnter *.function:setlocal filetype=c

" -----------------------------------------------------------------------------
" FZF

nnoremap <silent> <expr> <c-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files<cr>"
nnoremap <silent> <expr> <leader>F (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":BLines<cr>"
nnoremap <silent> <expr> <leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Rg<cr>"

" Integrate FZF into RipGrep
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

let g:fzf_action = {
            \ 'ctrl-o': 'drop',
            \ 'ctrl-s': 'vsplit'
            \ }

" -----------------------------------------------------------------------------
" Gutentags

" let g:gutentags_modules = ['ctags']
"
" let g:gutentags_cache_dir = expand('$XDG_CONFIG_HOME/vim/cache/ctags/')
"
" let g:gutentags_ctags_extra_args = [
"             \ '--languages=C,C++,Python',
"             \ '--exclude=*/platform/Device/*',
"             \ '--exclude=*/platform/base/*',
"             \ '--exclude=*/protocol/*/ThirdParty*',
"             \ '--exclude=*/protocol/*/third_party/*',
"             \ '--exclude=*/hardware/*',
"             \ '--exclude=*/util/third_party/*/third_party/*'
"             \ ]
"
" " Make sure to update status line on an event
" augroup MyGutentagsStatusLineRefresher
"     autocmd!
"     autocmd User GutentagsUpdating call lightline#update()
"     autocmd User GutentagsUpdated call lightline#update()
" augroup END

" -----------------------------------------------------------------------------
" Lightline

let g:lightline = {'colorscheme' : 'tokyonight'}

let g:lightline.active = {
            \ 'left': [ [ 'mode', 'paste' ],
            \           [ 'readonly', 'filename', 'modified', 'gutentags' ] ],
            \ 'right': [ [ 'percent' ],
            \            [ 'filetype' ] ] }
let g:lightline.inactive = {
            \ 'left': [ [ 'filename' ] ],
            \ 'right' : [] }
let g:lightline.component_function = {
            \ 'gutentags': 'gutentags#statusline'
            \ }


" -----------------------------------------------------------------------------
" NERDTree

map <leader>n :NERDTreeToggle<CR>

" Always start into NERDTree
autocmd VimEnter * NERDTree

" Close the tab if NERDTree is the only window remaining in it
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Width
let g:NERDTreeWinSize=50

" Content
let g:NERDTreeShowBookmarks=1
let g:NERDTreeBookmarksSort=0
let g:NERDTreeMinimalUI=1

" -----------------------------------------------------------------------------
" Tagbar

" nnoremap <leader>e :TagbarToggle<CR>
"
" let g:tagbar_autofocus = 1
" let g:tagbar_width = 50
" let g:tagbar_compact = 1
" let g:tagbar_visibility_symbols = {
"             \ 'public'    : '+',
"             \ 'protected' : '#',
"             \ 'private'   : '.'
"             \ }
"
" -----------------------------------------------------------------------------
"  UndoTree

" nnoremap <leader>u :UndotreeToggle<CR>

" -----------------------------------------------------------------------------
"  Vim-LSP

" let g:lsp_auto_enable = 1

" -----------------------------------------------------------------------------
" Colorscheme

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Remove ugly comment highlighting
set t_ZH=[3m
set t_ZR=[23m

" Match signs column to rest of theme (GitGutter)
augroup transparent_signs
    au!
    autocmd ColorScheme * highlight! SignColumn guibg=NONE
    autocmd ColorScheme * highlight! GitGutterAdd guibg=NONE
    autocmd ColorScheme * highlight! GitGutterChange guibg=NONE
    autocmd ColorScheme * highlight! GitGutterDelete guibg=NONE
    autocmd ColorScheme * highlight! GitGutterChangeDelete guibg=NONE
augroup END

let g:tokyonight_style='storm'
let g:tokyonight_enable_italic=0
let g:tokyonight_disable_italic_comment=1

colorscheme tokyonight
