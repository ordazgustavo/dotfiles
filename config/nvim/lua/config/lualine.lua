require'lualine'.setup {
	options = {
		theme = 'tokyonight',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch'},
		lualine_c = {
			{ 'diagnostics', sources = { 'nvim_lsp' } },
			'filename'
		},
		lualine_x = {'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	extensions = { 'nvim-tree' },
}
