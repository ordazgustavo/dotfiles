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
	use  'wbthomason/packer.nvim'

	-- LSP
	use {
		'neovim/nvim-lspconfig',
		requires = {'kabouzeid/nvim-lspinstall'},
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
	  config = [[require'config.telescope']],
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
		cmd = {'Format', 'FormatWrite'},
		config = [[require'config.formatters']]
	}

	-- UI
	use 'folke/tokyonight.nvim'
	use {
		'lewis6991/gitsigns.nvim',
		event = 'BufEnter',
		config = [[require'config.gitsigns']]
	}
	use 'kyazdani42/nvim-tree.lua'
	use {
	  'folke/lsp-trouble.nvim',
	  requires = 'kyazdani42/nvim-web-devicons',
	  config = function() require('trouble').setup() end,
	  cmd = 'LspTroubleToggle'
	}
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = [[require'config/lualine']]
	}
	use "romgrk/barbar.nvim"
end)
