-------------------------------------------------------------------------------
-- Telescope

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-------------------------------------------------------------------------------
-- Configuration

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter = require 'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<C-o>"] = actions.select_default,
        ["<C-l>"] = actions.select_vertical,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<C-o>"] = actions.select_default,
        ["<C-l>"] = actions.select_vertical,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["?"] = actions.which_key,
      },
    },

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker
  }
}

-------------------------------------------------------------------------------
-- Extesions

local tasks = telescope.extensions.tasks

tasks.generators.custom.add(function(buf)
  local cwd = vim.fn.getcwd()
  if string.find(cwd, "/gsdk") == nil then
    -- Generate this task only for files in the GSDK.
    return nil
  end

  local gsdk_path = os.getenv("GSDK_REPO")
  if (gsdk_path == nil) then
    -- Can't find GSDK_PATH.
    return nil
  end

  local relative_script_path =  'platform/security/script/lsp_explore.sh'

  return {
    {
      "Generate Compilation Database: All",
      cwd = gsdk_path,
      cmd = ("%s all"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Panther",
      cwd = gsdk_path,
      cmd = ("%s panther"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Lynx",
      cwd = gsdk_path,
      cmd = ("%s lynx"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Dumbo",
      cwd = gsdk_path,
      cmd = ("%s dumbo"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Sol",
      cwd = gsdk_path,
      cmd = ("%s sol"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Ocelot",
      cwd = gsdk_path,
      cmd = ("%s ocelot"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Bobcat",
      cwd = gsdk_path,
      cmd = ("%s bobcat"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Leopard",
      cwd = gsdk_path,
      cmd = ("%s leopard"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Rainier",
      cwd = gsdk_path,
      cmd = ("%s rainier"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Custom Board",
      cwd = gsdk_path,
      cmd = ("%s "):format(relative_script_path),
    },
  }
end)

-- Use FZF in order to speed up search
require('telescope').load_extension('tasks')
