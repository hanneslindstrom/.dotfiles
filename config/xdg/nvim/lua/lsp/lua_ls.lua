--------------------------------------------------------------------------------
-- Lua-LS: Lua Language Server
--------------------------------------------------------------------------------

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
  return
end

--------------------------------------------------------------------------------
-- Helper Functions

local neovim_init = function(client)

  local path = client.workspace_folders[1].name
  if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
    client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {

      runtime = {
        version = 'LuaJIT'
      },

      -- Make the server aware of Neovim runtime files
      workspace = {
        library = { vim.env.VIMRUNTIME }
      }
    })

    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end

  return true
end

--------------------------------------------------------------------------------
-- Setup

local M = {}

M.setup = function(capabilities, on_attach)
  lspconfig['lua_ls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150, },
    on_init = neovim_init,
  }
end

return M
