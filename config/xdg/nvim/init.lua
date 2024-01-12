-------------------------------------------------------------------------------
-- Hannes' NeoVim Configuration
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Package Manager

require('core/lazy')

-------------------------------------------------------------------------------
-- Core

require('core/autocmds')
require('core/keymaps')
require('core/colors')
require('core/options')

-------------------------------------------------------------------------------
-- LSP

require('lsp/lspconfig')

-------------------------------------------------------------------------------
-- Plugins

require('plugins/telescope')
require('plugins/nvim-cmp')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/lualine')
require('plugins/lspsaga')
require('plugins/lazygit')
require('plugins/fzf')
require('plugins/vim-tmux-navigator')
