-------------------------------------------------------------------------------
-- Keymaps
-------------------------------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-------------------------------------------------------------------------------
-- Basics

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- No Ex mode...
map('', 'Q', '<nop>')

-- Natural vertical movement
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Scrolling
map('n', 'J', '<C-y>')
map('n', 'K', '<C-e>')

-- Escape
map('', '<C-c>', '<Esc>')
map('!', '<C-c>', '<Esc>')

-- Clear search highlighting
map('n', '<space><space>', ':nohl<CR>')

-- Highlight current word
map("n", "gD", "*")

-- Toggle auto-indenting for code paste
map('n', '<leader>p', ':set invpaste paste?<CR>')
vim.opt.pastetoggle = '<leader>p'

-- Move around buffers
map('', '<leader>d', ':Bdelete<CR>')
map('', '<leader>n', ':enew<CR>')
map('', '<leader>j', ':bprevious<CR>')
map('', '<leader>k', ':bnext<CR>')

-- Resize windows
map('', '<S-left>', '<cmd> vertical resize -5<CR>')
map('', '<S-right>', '<cmd> vertical resize +5<CR>')
map('', '<S-down>', '<cmd> horizontal resize -2<CR>')
map('', '<S-up>', '<cmd> horizontal resize +2<CR>')

-- Fast saving
map('n', '<leader>s', ':up<CR>')

-- Close all windows and exit
map('n', '<leader>q', ':qa<CR>')

-- Move things around in visual mode
map('v', 'J', ':m \'>+1<CR>gv=gv')
map('v', 'K', ':m \'<-2<CR>gv=gv')

-------------------------------------------------------------------------------
-- Plugins

-------------------------------------------------------------------------------
-- Tmux Navigator

map('', '<C-h>', '<cmd> TmuxNavigateLeft<CR>')
map('', '<C-l>', '<cmd> TmuxNavigateRight<CR>')
map('', '<C-j>', '<cmd> TmuxNavigateDown<CR>')
map('', '<C-k>', '<cmd> TmuxNavigateUp<CR>')

-------------------------------------------------------------------------------
-- NvimTree

map('n', '<C-e>', ':NvimTreeToggle<CR>')

-------------------------------------------------------------------------------
-- LazyGit

map('n', '<C-g>', ':LazyGit<CR>')

-------------------------------------------------------------------------------
-- Telescope

-- map('n', '<C-p>', ':Telescope find_files<CR>')
-- map('n', '<C-f>', ':Telescope live_grep<CR>')
-- map('v', '<C-f>', 'y:Telescope live_grep default_text=<C-R>"<CR>')
map('n', '<space>t', ':Telescope tasks<CR>')

-------------------------------------------------------------------------------
-- FZF

map('n', '<C-p>', ':Files<CR>')
map('n', '<C-f>', ':Rg<CR>')
map('n', '<C-b>', ':BLines<CR>')
map('v', '<C-f>', 'y:Rg <C-R>"<CR>')

-------------------------------------------------------------------------------
-- LSPSaga

-- local keymap = vim.keymap.set

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
map("n", "gr", "<cmd>Lspsaga finder<CR>")

-- Hover Doc
map("n", "<space>h", "<cmd>Lspsaga hover_doc<CR>")

-- Toggle outline
map("n", "<space>o", "<cmd>Lspsaga outline<CR>")

-- Code actions
map("n", "<space>c", "<cmd>Lspsaga code_action<CR>")
