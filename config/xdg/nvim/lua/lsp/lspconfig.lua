-------------------------------------------------------------------------------
-- LSP Config
-------------------------------------------------------------------------------

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  -- Highlighting references
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

  -- Mappings
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>s', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>d', function()
    if vim.diagnostic.is_disabled() then
      vim.diagnostic.enable()
    else
      vim.diagnostic.disable()
    end
  end, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<space>p', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<space>n', vim.diagnostic.goto_next, opts)
end


-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Define `root_dir` when needed
-- See: https://github.com/neovim/nvim-lspconfig/issues/320
-- This is a workaround, maybe not work with some servers.
local root_dir = function()
  return vim.fn.getcwd()
end

--------------------------------------------------------------------------------
-- Server Setup

-- Python
lspconfig['pyright'].setup {
  on_attach = on_attach,
  root_dir = root_dir,
  capabilities = capabilities,
  flags = {
    -- default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

-- Bash
lspconfig['bashls'].setup {
  on_attach = on_attach,
  root_dir = root_dir,
  capabilities = capabilities,
  flags = {
    -- default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

-- Lua
lspconfig['lua_ls'].setup {
  on_attach = on_attach,
  root_dir = root_dir,
  capabilities = capabilities,
  flags = {
    -- default in neovim 0.7+
    debounce_text_changes = 150,
  },
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          library = { vim.env.VIMRUNTIME }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

-- YAML
local yaml_schemas = {}
local slc_schemas_dir = os.getenv('SLC_SCHEMA_DIR')
if (slc_schemas_dir ~= nil) then
  yaml_schemas[slc_schemas_dir .. '/slcc_metadata_schema.json'] = "*.slcc"
end
lspconfig['yamlls'].setup {
  on_attach = on_attach,
  root_dir = root_dir,
  capabilities = capabilities,
  flags = {
    -- default in neovim 0.7+
    debounce_text_changes = 150,
  },
  settings = {
    yaml = {
      schemas = yaml_schemas
    },
  }
}

-- C/C++
local clangd_command = {'/usr/local/opt/llvm@16/bin/clangd'}
local custom_gcc_dir = os.getenv('ARM_GCC_DIR')
local custom_riscv_gcc_dir = os.getenv('RISCV_GCC_DIR')
if (custom_gcc_dir ~= nil) then
  table.insert(clangd_command, '--query-driver=' .. custom_gcc_dir .. '/**')
end
if (custom_riscv_gcc_dir ~= nil) then
  table.insert(clangd_command, '--query-driver=' .. custom_riscv_gcc_dir .. '/**')
end
lspconfig['clangd'].setup {
  cmd = clangd_command,
  on_attach = on_attach,
  root_dir = root_dir,
  capabilities = capabilities,
  flags = {
    -- default in neovim 0.7+
    debounce_text_changes = 150,
  }
}
