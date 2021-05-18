local map = require'utils'.map

require 'format'.setup {
  -- ['*'] = {
  --   {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
  -- },
  javascript = {
    {cmd = {'prettier -w'}}
  },
  javascriptreact = {
    {cmd = {'prettier -w'}}
  },
  typescript = {
    {cmd = {'prettier -w'}},
  },
  typescriptreact = {
    -- {cmd = {'prettier -w'}},
    {cmd = {'eslint_d --fix'}},
  },
}

-- Formatter
map('n', '<leader>f', '<Cmd>Format<CR>')

vim.api.nvim_exec([[
augroup Format
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END
]], false)
