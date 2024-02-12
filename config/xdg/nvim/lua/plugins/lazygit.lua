--------------------------------------------------------------------------------
-- LazyGit: Integratation for the Greatest Git TUI
--------------------------------------------------------------------------------

local status_ok, _ = pcall(require, 'lazygit')
if not status_ok then
  return
end

--------------------------------------------------------------------------------
-- Options

vim.g.lazygit_floating_window_scaling_factor = 1.0

--------------------------------------------------------------------------------
-- Keymaps

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<C-g>', ':LazyGit<CR>', opts)
