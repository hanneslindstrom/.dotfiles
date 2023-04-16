-------------------------------------------------------------------------------
-- LSPSaga
-------------------------------------------------------------------------------

local status_ok, lspsaga = pcall(require, 'lspsaga')
if not status_ok then
  return
end

lspsaga.setup {
  symbol_in_winbar = {
    enable = false,
    separator = " ",
    ignore_patterns={},
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
  },
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder = {
    default = 'def+imp+ref'
  },
  -- rename = {
  --   quit = "<C-c>",
  --   exec = "<CR>",
  --   mark = "<space>",
  --   confirm = "<CR>",
  --   in_select = true,
  -- },
}
