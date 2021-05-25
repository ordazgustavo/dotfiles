local map = require'utils'.map

map('n', '<C-n>', ':NvimTreeToggle<CR>')
map('n', '<leader>nr', ':NvimTreeRefresh<CR>')
-- hide folders/files from NvimTree
vim.g.nvim_tree_ignore = { '.git', '.DS_Store' }
-- compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_group_empty = 1
