--------------------------------------------------------------------------------
-- Yaml-LS: YAML Language Server
--------------------------------------------------------------------------------

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
  return
end

--------------------------------------------------------------------------------
-- Schemas

local yaml_schemas = {}

-- SLC
local slc_schemas_dir = os.getenv('SLC_SCHEMA_DIR')
if (slc_schemas_dir ~= nil) then
  yaml_schemas[slc_schemas_dir .. '/slcc_metadata_schema.json'] = "*.slcc"
end

--------------------------------------------------------------------------------
-- Setup

local M = {}

M.setup = function(capabilities, on_attach)
  lspconfig['yamlls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150, },
    settings = {
      yaml = {
        schemas = yaml_schemas
      },
    }
  }
end

return M
