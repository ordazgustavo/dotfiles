local function lspError()
  if not vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
      local error_count = vim.lsp.diagnostic.get_count(0, 'Error')
      return ' ' .. error_count
  else
      return ''
  end
end

local function lspWarning()
  if not vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
      local warning_count = vim.lsp.diagnostic.get_count(0, 'Warning')
	  return ' ' .. warning_count
  else
      return ''
  end
end

local function lspInfo()
  if not vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
      local info_count = vim.lsp.diagnostic.get_count(0, 'Information')
		  + vim.lsp.diagnostic.get_count(0, 'Hint')
	  return ' ' .. info_count
  else
      return ''
  end
end

require('lualine').setup {
	options = {
		theme = 'tokyonight',
	},
	sections = {
	  lualine_a = {'mode'},
	  lualine_b = {'branch'},
	  lualine_c = {'filename'},
	  lualine_x = {
		{ lspError, color = { fg = '#db4b4b', bg = '#1f2335' } },
		{ lspWarning, color = { fg = '#e0af68', bg = '#1f2335' } },
		{ lspInfo, color = { fg = '#1abc9c', bg = '#1f2335' } },
		'encoding',
		'fileformat',
		'filetype'
	  },
	  lualine_y = {'progress'},
	  lualine_z = {'location'}
	},
	extensions = { 'nvim-tree' },
}
