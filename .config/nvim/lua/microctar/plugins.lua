local installed, packer = pcall(require, "packer")

if (not installed) then
  print("packer.nvim is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'

  use {
    'rcarriga/nvim-dap-ui', requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
  }

  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    
    'nvimtools/none-ls.nvim',
    'glepnir/lspsaga.nvim',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use {
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'lewis6991/gitsigns.nvim',
    'uga-rosa/ccc.nvim',
    'nvim-lualine/lualine.nvim',
  }

  use {
    after = "catppuccin",
    'akinsho/bufferline.nvim',
    tag = "v3.*",
  }

  use {
	  "windwp/nvim-autopairs",
    'windwp/nvim-ts-autotag'
  }

  use {
    'catppuccin/nvim',
    as = 'catppuccin'
  }

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
end)
