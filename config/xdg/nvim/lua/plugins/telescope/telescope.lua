--------------------------------------------------------------------------------
-- Telescope: Multi-Purpose Picker Tool
--------------------------------------------------------------------------------

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

--------------------------------------------------------------------------------
-- UI

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#545454" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "" })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#f0a8d7" })
vim.api.nvim_set_hl(0, "TelescopeMultiSelection", { fg = "#f8bd86" })

-- Apply comment highlighting to line and column numbers in results list
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescoParent", ":[0-9]\\+")
      vim.api.nvim_set_hl(0, "TelescoParent", { link = "Comment" })
    end)
  end,
})

--------------------------------------------------------------------------------
-- Global Keymaps

local opts = { noremap=true, silent=false }
vim.api.nvim_set_keymap('n', '<space>t', ':Telescope tasks<CR>', opts)

--------------------------------------------------------------------------------
-- Setup

----------------------------------------
-- Core Setup

local actions = require("telescope.actions")

local setup_opts = {
  defaults = {

    -- General
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "limit",

    -- UI
    layout_strategy = "vertical",
    prompt_prefix = "> ",
    selection_caret = " ",
    multi_icon = " ",
    entry_prefix = "  ",
    layout_config = {
      vertical = {
        height = 0.9,
        preview_cutoff = 40,
        prompt_position = "bottom",
        width = 0.9
      }
    },

    -- Keymaps While Attached
    mappings = {
      i = {
        ["<C-o>"] = actions.select_default,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<esc>"] = actions.close,
        ["q"] = actions.close,
        ["<C-o>"] = actions.select_default,
        ["o"] = actions.select_default,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["<C-j>"] = actions.nop,
        ["<C-k>"] = actions.nop,
        ["<Space>"] = actions.toggle_selection,
        ["<C-q>"] = actions.send_selected_to_qflist,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["K"] = actions.preview_scrolling_up,
        ["J"] = actions.preview_scrolling_down,
        ["?"] = actions.which_key,
      },
    },

  },
}

----------------------------------------
-- Extensions

-- FZF
setup_opts.extensions = {
  fzf = {
    fuzzy = true,
    override_generic_sorter = true,
    override_file_sorter = true,
    case_mode = "smart_case",
  }
}

-- Tasks
require("plugins/telescope/tasks").add_tasks_generators(telescope.extensions.tasks)

----------------------------------------
-- Finish Setup

telescope.setup(setup_opts)

----------------------------------------
-- Load Extensions

telescope.load_extension('fzf')
telescope.load_extension('tasks')
