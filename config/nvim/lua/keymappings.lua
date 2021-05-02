local u = require'utils'

-- Set leader
u.remap('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- indenting
u.remap('v', '<', '<gv')
u.remap('v', '>', '>gv')

-- window movement
u.remap('n', '<C-h>', '<C-w>h', { silent = true })
u.remap('n', '<C-j>', '<C-w>j', { silent = true })
u.remap('n', '<C-k>', '<C-w>k', { silent = true })
u.remap('n', '<C-l>', '<C-w>l', { silent = true })

-- Move selected line / block of text in visual mode
u.remap('x', 'K', ':move \'<-2<CR>gv-gv')
u.remap('x', 'J', ':move \'>+1<CR>gv-gv')

-- NvimTree
u.remap('n', '<C-n>', ':NvimTreeToggle<CR>')
u.remap('n', '<leader>nr', ':NvimTreeRefresh<CR>')
-- open NvimTree by default
-- vim.g.nvim_tree_auto_open = 1
-- hide folders from NvimTree
vim.g.nvim_tree_ignore = { '.git' }
-- compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_group_empty = 1

-- LSP trouble
u.remap('n', '<leader>xx', '<cmd>LspTroubleToggle<cr>')

