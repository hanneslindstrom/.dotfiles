--------------------------------------------------------------------------------
-- Nvim-Tree: File Explorer
--------------------------------------------------------------------------------

local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

local api = require("nvim-tree.api")

--------------------------------------------------------------------------------
-- Helper Functions

local function cd_to_node()
  local node = api.tree.get_node_under_cursor()
  if node.type == nil then
    return vim.fn.chdir(api.tree.get_nodes()['absolute_path'])
  elseif node.type == 'directory' then
    return vim.fn.chdir(node.absolute_path)
  end
end

--------------------------------------------------------------------------------
-- Keymaps

----------------------------------------
-- Global

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<C-e>', ':NvimTreeToggle<CR>', opts)

----------------------------------------
-- On Attach

local function my_on_attach(bufnr)
  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  -- Set default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Set custom mappings
  vim.keymap.set('n', '<C-e>', api.tree.toggle, opts('Toggle'))
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'CD', api.tree.change_root_to_node, opts('Change Tree Root'))
  vim.keymap.set('n', 'cd', cd_to_node, opts('Change CWD'))
  vim.keymap.set('n', 'v', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'n', api.marks.navigate.next, opts('Next Bookmark'))
  vim.keymap.set('n', 'N', api.marks.navigate.prev, opts('Prev Bookmark'))
  vim.keymap.set('n', 'd', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'D', api.fs.remove, opts('Delete'))
end

--------------------------------------------------------------------------------
-- Setup

nvim_tree.setup({

  -- General
  on_attach = my_on_attach,
  actions = {
    change_dir = {
      enable = true,
      global = true,
    },
  },

  -- UI
  view = {
    width = 40,
    preserve_window_proportions = true,
  },
  ui = {
    confirm = {
      remove = true,
      trash = false,
    },
  },

  -- Disabled Features
  log = {
    enable = false,
  },
  git = {
    enable = false,
  },
  modified = {
    enable = false,
  },

})
