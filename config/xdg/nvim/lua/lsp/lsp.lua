--------------------------------------------------------------------------------
-- LSP: Basic LSP Configuration
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Helper Functions

----------------------------------------
-- Core

local toggle_diagnostics = function(bufnr)
  if vim.diagnostic.is_disabled(bufnr) then
    vim.diagnostic.enable(bufnr)
  else
    vim.diagnostic.disable(bufnr)
  end
end

----------------------------------------
-- Telescope

local telescope_status_ok, telescope_builtin = pcall(require, "telescope.builtin")

local telescope_list_references = function()
  if not telescope_status_ok then
    return
  end
  telescope_builtin.lsp_references({
    show_line = false,
    include_current_line = true,
    include_declaration = false,
    jump_type = "never",
  })
end

local telescope_list_symbols = function()
  if not telescope_status_ok then
    return
  end
  require("telescope.builtin").lsp_document_symbols({
    symbol_width = 50
  })
end

--------------------------------------------------------------------------------
-- UI

-- General
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- Window Style
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Signs
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

--------------------------------------------------------------------------------
-- Common Setup

local on_attach = function(client, bufnr)

  -- Dynamic Highlighting
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end

  -- Keymaps
  local opts = { noremap = true, silent = false, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gR', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', telescope_list_references, opts)
  vim.keymap.set('n', 'gs', telescope_list_symbols, opts)
  vim.keymap.set('n', '<space>s', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<space>d', function() toggle_diagnostics(bufnr) end, opts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<space>N', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<space>n', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>c', vim.lsp.buf.code_action, opts)
end

--------------------------------------------------------------------------------
-- Capabilities

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if status_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

--------------------------------------------------------------------------------
-- Server Setup

require("lsp/bashls").setup(capabilities, on_attach)
require("lsp/clangd").setup(capabilities, on_attach)
require("lsp/lua_ls").setup(capabilities, on_attach)
require("lsp/pyright").setup(capabilities, on_attach)
require("lsp/yamlls").setup(capabilities, on_attach)
