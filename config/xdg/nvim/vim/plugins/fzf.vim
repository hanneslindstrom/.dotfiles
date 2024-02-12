"-------------------------------------------------------------------------------
" FZF: Best Perfomance File-Finder for Large Projects
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Command Definitions

command! -bang -nargs=* Rg call fzf#vim#grep("rg --trim --hidden --no-ignore --no-heading --line-number --column --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': ['--delimiter=:', '--nth=4..', '--border-label= RipGrep ']}), <bang>0)
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--border-label= FZF ']}), <bang>0)

"-------------------------------------------------------------------------------
" UI

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

"-------------------------------------------------------------------------------
" Keymaps

let g:fzf_action = { 'ctrl-o': 'open' }

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :BLines<CR>
nnoremap <silent> <C-f> :Rg<CR>
vnoremap <silent> <C-f> y:Rg <C-R>"<CR>
