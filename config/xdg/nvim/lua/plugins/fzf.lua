vim.cmd([[

" Integrate FZF into RipGrep
command! -bang -nargs=* Rg call fzf#vim#grep("rg --trim --hidden --no-ignore --no-heading --line-number --column --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': ['--delimiter=:', '--nth=4..', '--border-label= RipGrep ']}), <bang>0)
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--border-label= FZF ']}), <bang>0)

let g:fzf_action = {
            \ 'ctrl-o': 'drop'
            \ }
]])
