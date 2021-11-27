local map = require'utils'.map

map('n', '<C-n>', ':NvimTreeToggle<CR>')
map('n', '<leader>nr', ':NvimTreeRefresh<CR>')

-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
}
