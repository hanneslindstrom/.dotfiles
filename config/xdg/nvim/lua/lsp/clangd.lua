--------------------------------------------------------------------------------
-- Clangd: C and C++ Language Server
--------------------------------------------------------------------------------

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
  return
end

--------------------------------------------------------------------------------
-- Language Server Path

local clangd_command = { '/usr/local/opt/llvm@16/bin/clangd' }
local custom_gcc_dir = os.getenv('ARM_GCC_DIR')
local custom_riscv_gcc_dir = os.getenv('RISCV_GCC_DIR')
if (custom_gcc_dir ~= nil) then
  table.insert(clangd_command, '--query-driver=' .. custom_gcc_dir .. '/**')
end
if (custom_riscv_gcc_dir ~= nil) then
  table.insert(clangd_command, '--query-driver=' .. custom_riscv_gcc_dir .. '/**')
end

--------------------------------------------------------------------------------
-- Setup

local M = {}

M.setup = function(capabilities, on_attach)
  lspconfig['clangd'].setup {
    cmd = clangd_command,
    on_attach = on_attach,
    capabilities = capabilities,
    -- root_dir = root_dir,
    flags = { debounce_text_changes = 150, },
  }
end

return M
