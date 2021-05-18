local map = require'utils'.map

-- Set leader
map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- window movement
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Move selected line / block of text in visual mode
map('x', 'K', ':move \'<-2<CR>gv-gv')
map('x', 'J', ':move \'>+1<CR>gv-gv')

-- Save
map('n', '<leader>w', ':w<CR>')
-- Save and quit
map('n', '<leader>x', ':x<CR>')

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')
map('n', '<leader>nr', ':NvimTreeRefresh<CR>')
-- hide folders from NvimTree
vim.g.nvim_tree_ignore = { '.git' }
-- compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_group_empty = 1

-- LSP trouble
map('n', '<leader>xx', '<cmd>LspTroubleToggle<cr>')

-- Terminal
map('n', '<leader>t', '<cmd>split | terminal<cr>')

-- BarBar
map('n', '<leader>c', ':BufferClose<CR>')
-- Change buffer
map('n', '<leader>n', ':BufferNext<CR>')
map('n', '<leader>p', ':BufferPrevious<CR>')
-- Reorder buffers
map('n', '<leader>.', ':BufferMoveNext<CR>')
map('n', '<leader>,', ':BufferMovePrevious<CR>')
-- Go to buffer in position
map('n', '<leader>1', ':BufferGoto 1<CR>')
map('n', '<leader>2', ':BufferGoto 2<CR>')
map('n', '<leader>3', ':BufferGoto 3<CR>')
map('n', '<leader>4', ':BufferGoto 4<CR>')
map('n', '<leader>5', ':BufferGoto 5<CR>')
map('n', '<leader>6', ':BufferGoto 6<CR>')
map('n', '<leader>7', ':BufferGoto 7<CR>')
map('n', '<leader>8', ':BufferGoto 8<CR>')
map('n', '<leader>9', ':BufferGoto 9<CR>')
