require("lazy").setup({
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function(

    )
      require("rose-pine").setup {}
      vim.cmd("colorscheme rose-pine")
    end
  }, -- Theme
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require 'nvim-web-devicons'.setup {}
    end
  },
  'MunifTanjim/nui.nvim',  -- UI framework
  'nvim-lua/plenary.nvim', -- Utility functions
  "nvim-tree/nvim-web-devicons",
  -- Auto completion
  { 'github/copilot.vim',              build = ':Copilot setup' },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<D-1>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
      { 'P', }
    },
    config = function()
      require('config.neotree').setup()
    end
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config =
        function()
          require("config.bufferline")
        end
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('config.lualine')
    end
  },
  'arkav/lualine-lsp-progress',
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        autotag = {
          enable = true,
        }
      }
      -- require('nvim-ts-autotag').setup()
    end,
  },
  -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
  {
    "williamboman/mason.nvim",
    config = function()
      require 'config.lsp'
    end
  },
  { "folke/neodev.nvim", opts = {} },
  "williamboman/mason-lspconfig.nvim",
  -- cmp-nvim
  'onsails/lspkind.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  "hrsh7th/cmp-nvim-lua",
  'hrsh7th/cmp-nvim-lsp',
  "hrsh7th/cmp-nvim-lsp-signature-help",
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  "neovim/nvim-lspconfig",
  -- For ultisnips users.
  'SirVer/ultisnips',
  'quangnguyen30192/cmp-nvim-ultisnips',
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  }
})
