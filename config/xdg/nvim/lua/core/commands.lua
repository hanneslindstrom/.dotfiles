--------------------------------------------------------------------------------
-- Command-Line Aliases and Helpful Commands
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- General

vim.api.nvim_create_user_command('Cclear', ':cexp []', {})
vim.api.nvim_create_user_command('Lclear', ':lexp []', {})
vim.api.nvim_create_user_command('Tclear', "call settagstack(winnr(), {'items' : []})", {})
