local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Compile this file every time it chages
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

require('packer').startup(function (use)
  use 'wbthomason/packer.nvim'

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {'williamboman/nvim-lsp-installer'},
    config = [[require'config.lsp']]
  }
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/lsp_extensions.nvim'

  -- TreeSitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[require'config.treesitter']]
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    setup = [[require'config.telescope_setup']],
    config = [[require'config.telescope']],
    cmd = 'Telescope'
  }

  -- Languages
  use {'rust-lang/rust.vim', ft = {'rust', 'toml'}}
  use {'leafgarland/typescript-vim', ft = {'typescript', 'typescriptreact'}}

  -- Utils
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use {'tpope/vim-fugitive', cmd = {'Git', 'G'}}
  use {
    'lukas-reineke/format.nvim',
    config = [[require'config.formatters']]
  }

  -- UI
  use 'kyazdani42/nvim-web-devicons'
  use 'folke/tokyonight.nvim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    event = 'BufEnter',
    config = [[require'config.gitsigns']]
  }
  use {'kyazdani42/nvim-tree.lua', config = [[require'config/nvimtree']]}
  use {
    'folke/lsp-trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('trouble').setup() end,
    cmd = 'LspTroubleToggle'
  }
  use {'hoob3rt/lualine.nvim', config = [[require'config/lualine']]}
  use 'romgrk/barbar.nvim'
  use {'glepnir/dashboard-nvim', config = [[require'config/dashboard']]}
  use {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
end)
