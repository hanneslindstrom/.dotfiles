-------------------------------------------------------------------------------
-- Treesitter: Solid Syntax Parser for Good Coloring
-------------------------------------------------------------------------------

local status_ok, nvim_treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

-------------------------------------------------------------------------------
-- Setup

nvim_treesitter_configs.setup {

  -- Basics
  sync_install = true,
  highlight = { enable = true },
  ignore_install = { },
  modules = { },
  auto_install = false,

  -- Supported Languages
  ensure_installed = {
    'bash', 'c', 'cpp', 'json', 'lua', 'python', 'rust', 'vim', 'yaml',
    'markdown', 'markdown_inline',
  },

}
