--------------------------------------------------------------------------------
-- PyRight: Python Language Server
--------------------------------------------------------------------------------

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
  return
end

--------------------------------------------------------------------------------
-- Setup

local M = {}

M.setup = function(capabilities, on_attach)
  lspconfig['pyright'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150, },
  }
end

return M
