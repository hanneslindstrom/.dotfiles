-------------------------------------------------------------------------------
-- Plugin manager configuration file
-------------------------------------------------------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

-- Start setup
lazy.setup({
  spec = {
    -- Colorscheme:
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },

    -- Git labels
    {
      'lewis6991/gitsigns.nvim',
      lazy = false,
      dependencies = {
        'nvim-lua/plenary.nvim',
        -- 'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('gitsigns').setup {}
      end
    },

    -- Fugitive
    { 'tpope/vim-fugitive' },

    -- LazyGit
    {
      "kdheepak/lazygit.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },

    -- Telescope
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'lpoto/telescope-tasks.nvim'
      }
    },

    -- FZF
    {
      'junegunn/fzf.vim',
      dependencies = {
        'junegunn/fzf',
      }
    },

    -- Lualine
    { 'nvim-lualine/lualine.nvim' },

    -- Nvim-Tree
    {
      'kyazdani42/nvim-tree.lua',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    -- BufDelete
    {
      'famiu/bufdelete.nvim'
    },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- Tmux navigator
    { 'christoomey/vim-tmux-navigator' },

    -- Nvim-Comment
    {
      'terrortylor/nvim-comment',
      event = 'InsertEnter',
      config = function()
        require('nvim_comment').setup {}
      end
    },

    -- Autopair
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup {}
      end
    },

    -- LSP
    { 'neovim/nvim-lspconfig' },

    -- LSPSaga
    {
      "glepnir/lspsaga.nvim",
      event = "LspAttach",
      dependencies = {
        -- { "nvim-tree/nvim-web-devicons" },
        -- Please make sure you install markdown and markdown_inline parser
        { "nvim-treesitter/nvim-treesitter" }
      }
    },

    -- Autocomplete
    {
      'hrsh7th/nvim-cmp',
      -- load cmp on InsertEnter
      event = 'InsertEnter',
      -- these dependencies will only be loaded when cmp loads
      -- dependencies are always lazy-loaded unless specified otherwise
      dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
      },
    },
  },
  ui = {
    size = { width = 1, height = 1 },
  }
})
