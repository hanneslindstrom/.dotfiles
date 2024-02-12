--------------------------------------------------------------------------------
-- Lazy: NeoVim Package Manager
--------------------------------------------------------------------------------

-- Bootstrap Lazy
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

local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

--------------------------------------------------------------------------------
-- Setup

lazy.setup({

  -- UI
  ui = {
    size = { width = 1, height = 1 },
  },

  -- Packages
  spec = {

    -- User Interface
    {
      "folke/tokyonight.nvim",
    },
    {
      'nvim-lualine/lualine.nvim'
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate'
    },

    -- Basics
    {
      'christoomey/vim-tmux-navigator'
    },
    {
      'famiu/bufdelete.nvim'
    },
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'lpoto/telescope-tasks.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          build =
          'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        },
      }
    },

    -- Improved Code Editing
    {
      'neovim/nvim-lspconfig'
    },
    {
      'terrortylor/nvim-comment',
      event = 'InsertEnter',
      config = function()
        require('nvim_comment').setup {}
      end
    },
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup {}
      end
    },
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
      },
    },

    -- Git Integration
    {
      'tpope/vim-fugitive',
    },
    {
      "kdheepak/lazygit.nvim",
      lazy = true,
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    {
      'lewis6991/gitsigns.nvim',
      lazy = false,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('gitsigns').setup {}
      end
    },

    -- File Navigation
    {
      'junegunn/fzf.vim',
      dependencies = {
        'junegunn/fzf',
      }
    },
    {
      'kyazdani42/nvim-tree.lua',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

  },

})
