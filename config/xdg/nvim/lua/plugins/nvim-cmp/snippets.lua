--------------------------------------------------------------------------------
-- Snippets Source for Nvim-Cmp
--------------------------------------------------------------------------------

local status_ok, luasnip = pcall(require, 'luasnip')
if not status_ok then
  return
end

local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
  return
end

local snippets_path = os.getenv('XDG_DATA_HOME') .. "/nvim/snippets"
require("luasnip/loaders/from_vscode").lazy_load({
  paths = snippets_path
})

--------------------------------------------------------------------------------
-- Helper Functions

local expand_snippet = function(fallback)
  if luasnip.expandable() then
    luasnip.expand()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif cmp.visible() then
    cmp.confirm()
  else
    fallback()
  end
end

--------------------------------------------------------------------------------
-- Setup

local M = {}

M.add_snippets_setup_options = function(opts)
  local opts = opts or {}

  -- General
  opts.snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  }

  -- Keymaps
  opts.mapping["<Tab>"] = cmp.mapping(expand_snippet, { "i", "s" })

  return opts
end

return M
