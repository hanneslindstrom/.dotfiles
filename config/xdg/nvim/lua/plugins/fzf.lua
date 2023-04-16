vim.cmd([[

" Integrate FZF into RipGrep
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

let g:fzf_action = {
            \ 'ctrl-o': 'drop',
            \ 'ctrl-s': 'vsplit'
            \ }
]])
