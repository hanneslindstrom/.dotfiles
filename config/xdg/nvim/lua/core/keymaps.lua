--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Helper Functions

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--------------------------------------------------------------------------------
-- Basics

-- Change leader to a comma
vim.g.mapleader = ','

-- No Ex mode...
map('', 'Q', '<nop>')

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Escape
map('', '<C-c>', '<Esc>')
map('!', '<C-c>', '<Esc>')

--------------------------------------------------------------------------------
-- Text Editing

-- Natural vertical movement
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Improved navigation in insert mode
map("i", "<C-h>", "<left>")
map("i", "<C-j>", "<down>")
map("i", "<C-k>", "<up>")
map("i", "<C-l>", "<right>")
map("i", "<C-a>", "<home>")
map("i", "<C-e>", "<end>")

-- Scrolling
map('n', 'J', '<C-y>')
map('n', 'K', '<C-e>')

-- Move things around in visual mode
map('v', 'J', ':m \'>+1<CR>gv=gv')
map('v', 'K', ':m \'<-2<CR>gv=gv')

-- Clear search highlighting
map('n', '<space><space>', ':nohl<CR>')

-- Highlight current word
map("n", "gD", "*")

-- Toggle auto-indenting for code paste
map('n', '<leader>p', ':set invpaste paste?<CR>')
vim.opt.pastetoggle = '<leader>p'

--------------------------------------------------------------------------------
-- Buffer Management

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
