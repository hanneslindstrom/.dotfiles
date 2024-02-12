--------------------------------------------------------------------------------
-- Nvim-Cmp: Must-Have Autocomplete
--------------------------------------------------------------------------------

local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

--------------------------------------------------------------------------------
-- Helper Functions

local filter_lsp_entry = function(entry)
  return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
end

local lookup_source_menu_tag = function(entry, vim_item)
  vim_item.menu = ({
    nvim_lsp = "[LSP]",
    luasnip = "[Snip]",
    buffer = "[Buf]",
    path = "[Path]",
  })[entry.source.name]

  return vim_item
end

--------------------------------------------------------------------------------
-- Setup

----------------------------------------
-- Core Setup

local setup_opts = {

  -- General
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  performance = {
    max_view_entries = 13
  },

  -- Sources
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp", entry_filter = filter_lsp_entry },
    { name = "buffer" },
    { name = "path" },
  },

  -- UI
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  experimental = {
    ghost_text = false,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lookup_source_menu_tag,
  },

  -- Keymaps
  mapping = {
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["J"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["K"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping.confirm { select = true },
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
    ["<CR>"] = cmp.mapping.confirm { select = false },
  },

}

----------------------------------------
-- External Sources Setup

setup_opts = require("plugins/nvim-cmp/snippets").add_snippets_setup_options(setup_opts)

----------------------------------------
-- Finish Setup

cmp.setup(setup_opts)
