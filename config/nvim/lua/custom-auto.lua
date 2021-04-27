vim.api.nvim_exec([[
	augroup cleanup
		autocmd!
		autocmd BufWritePre * %s/\s\+$//e
	augroup END
]], false)

vim.api.nvim_exec([[
	augroup highlight_yank
		autocmd!
		autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
	augroup END
]], false)

