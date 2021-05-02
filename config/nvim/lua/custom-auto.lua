vim.api.nvim_exec([[
augroup Format
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END
]], false)

vim.api.nvim_exec([[
augroup highlight_yank
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 50})
augroup END
]], false)

