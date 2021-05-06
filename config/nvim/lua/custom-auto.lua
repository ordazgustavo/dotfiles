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

-- Update colorcolumn for Rust files
vim.api.nvim_exec([[
augroup UpdateColorColumn
    autocmd!
    autocmd BufEnter *.rs set colorcolumn=100
    autocmd BufEnter *.js set softtabstop=0 expandtab shiftwidth=2 smarttab
    autocmd BufEnter *.jsx set softtabstop=0 expandtab shiftwidth=2 smarttab
    autocmd BufEnter *.ts set softtabstop=0 expandtab shiftwidth=2 smarttab
    autocmd BufEnter *.tsx set softtabstop=0 expandtab shiftwidth=2 smarttab
augroup END
]], false)

