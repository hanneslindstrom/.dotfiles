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
    max_height = 0.7,
    left_width = 0.3,
    right_width = 0.7,
    default = 'def+dec+ref',
     methods = {
      def = 'textDocument/definition',
      dec = 'textDocument/declaration',
      ref = 'textDocument/references'
    }
  },
  -- rename = {
  --   quit = "<C-c>",
  --   exec = "<CR>",
  --   mark = "<space>",
  --   confirm = "<CR>",
  --   in_select = true,
  -- },
}
