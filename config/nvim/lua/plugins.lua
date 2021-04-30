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

require('packer').startup(function ()
	use 'wbthomason/packer.nvim'

	-- LSP
	use 'neovim/nvim-lspconfig'
	use 'nvim-lua/completion-nvim'
	use 'nvim-lua/lsp_extensions.nvim'
	-- use 'glepnir/lspsaga.nvim'

	-- TreeSitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- Telescope
	use {
	  'nvim-telescope/telescope.nvim',
	  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}

	-- Languages
	use 'rust-lang/rust.vim'
	use 'leafgarland/typescript-vim'

	-- Utils
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-fugitive'

	-- UI
	use 'folke/tokyonight.nvim'
	use 'lewis6991/gitsigns.nvim'
	use 'kyazdani42/nvim-tree.lua'

	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function()
			require('lualine').setup {
				options = {
					theme = 'tokyonight',
				}
			}
		end
	}

	-- use "romgrk/barbar.nvim"
end)
