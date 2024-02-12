--------------------------------------------------------------------------------
-- Lualine: Actually Good Looking Status Line
--------------------------------------------------------------------------------

local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

--------------------------------------------------------------------------------
-- Setup

lualine.setup {

  -- Options
  options = {

    -- UI
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},

    -- General
    disabled_filetypes = {
      statusline = {'NvimTree'},
    },

    -- Needs to be set for some reason, otherwise FZF messes up status line
    globalstatus = false,
  },

  -- Sections
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'searchcount', 'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },

}
