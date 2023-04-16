-------------------------------------------------------------------------------
-- LazyGit
-------------------------------------------------------------------------------

local status_ok, lazygit = pcall(require, 'lazygit')
if not status_ok then
  return
end

vim.g.lazygit_floating_window_scaling_factor = 1.0
