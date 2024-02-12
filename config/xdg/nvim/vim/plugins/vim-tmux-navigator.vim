"-------------------------------------------------------------------------------
" Vim-Tmux-Navigator: Seamless Navigation Between Tmux and NeoVim
"-------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Options

let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_wrap = 1

" ------------------------------------------------------------------------------
" Options

noremap <silent> <C-h> :TmuxNavigateLeft<CR>
noremap <silent> <C-l> :TmuxNavigateRight<CR>
noremap <silent> <C-j> :TmuxNavigateDown<CR>
noremap <silent> <C-k> :TmuxNavigateUp<CR>
