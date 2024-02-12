--------------------------------------------------------------------------------
-- Hannes's NeoVim Configuration
--------------------------------------------------------------------------------

local vim_require = function(path)
  local xdg_config = os.getenv("XDG_CONFIG_HOME")
  if (xdg_config == nil) then
    return nil
  end

  local vim_dir = xdg_config .. '/nvim/vim/'
  local command = 'source ' .. vim_dir .. path
  vim.cmd(command)
end

--------------------------------------------------------------------------------
-- Modules

require('plugins/lazy')

----------------------------------------
-- Core

require('core/autocmds')
require('core/commands')
require('core/keymaps')
require('core/options')

----------------------------------------
-- LSP

require('lsp/lsp')

----------------------------------------
-- Plugins

-- Lua
require('plugins/lualine')
require('plugins/lazygit')
require('plugins/nvim-cmp/nvim-cmp')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/telescope/telescope')

-- VimScript
vim_require('plugins/fzf.vim')
vim_require('plugins/vim-tmux-navigator.vim')
