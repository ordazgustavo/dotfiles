vim.api.nvim_exec([[
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 50})
augroup END
]], false)

vim.api.nvim_exec([[
augroup eslint_fix
  autocmd!
  autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>
augroup END
]], false)


-- Useful defaults for terminal windows
vim.api.nvim_exec([[
augroup neovim_terminal
  autocmd!
  " Enter Terminal-mode (insert) automatically
  autocmd TermOpen * startinsert
  " Disables number lines on terminal buffers
  autocmd TermOpen * :set nonumber norelativenumber
  " allows you to use Ctrl-c on terminal window
  autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END
]], false)
