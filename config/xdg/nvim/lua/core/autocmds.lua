--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

--------------------------------------------------------------------------------
-- General

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Don't auto comment new lines
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})

--------------------------------------------------------------------------------
-- File-Type Specific

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = {
    'c', 'c++', 'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- Use C++ style comments
autocmd('Filetype', {
  pattern = {
    'c'
  },
  callback = function()
    vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
  end,
})

-- Custom file types
autocmd('BufRead', {
  pattern = {
    '*.slc*'
  },
  command = 'set ft=yaml'
})
autocmd('BufRead', {
  pattern = {
    '*.function'
  },
  command = 'set ft=c'
})
