local u = require'utils'

-- Set leader
u.remap('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- indenting
u.remap('v', '<', '<gv')
u.remap('v', '>', '>gv')

-- window movement
u.remap('n', '<C-h>', '<C-w>h')
u.remap('n', '<C-j>', '<C-w>j')
u.remap('n', '<C-k>', '<C-w>k')
u.remap('n', '<C-l>', '<C-w>l')

-- Move selected line / block of text in visual mode
u.remap('x', 'K', ':move \'<-2<CR>gv-gv')
u.remap('x', 'J', ':move \'>+1<CR>gv-gv')

-- Save
u.remap('n', '<leader>w', ':w<CR>')
-- Save and quit
u.remap('n', '<leader>x', ':x<CR>')

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

-- Terminal
u.remap('n', '<leader>t', '<cmd>split | terminal<cr>')

-- BarBar
u.remap('n', '<leader>c', ':BufferClose<CR>')
-- Change buffer
u.remap('n', '<leader>n', ':BufferNext<CR>')
u.remap('n', '<leader>p', ':BufferPrevious<CR>')
-- Reorder buffers
u.remap('n', '<leader>.', ':BufferMoveNext<CR>')
u.remap('n', '<leader>,', ':BufferMovePrevious<CR>')
-- Go to buffer in position
u.remap('n', '<leader>1', ':BufferGoto 1<CR>')
u.remap('n', '<leader>2', ':BufferGoto 2<CR>')
u.remap('n', '<leader>3', ':BufferGoto 3<CR>')
u.remap('n', '<leader>4', ':BufferGoto 4<CR>')
u.remap('n', '<leader>5', ':BufferGoto 5<CR>')
u.remap('n', '<leader>6', ':BufferGoto 6<CR>')
u.remap('n', '<leader>7', ':BufferGoto 7<CR>')
u.remap('n', '<leader>8', ':BufferGoto 8<CR>')
u.remap('n', '<leader>9', ':BufferGoto 9<CR>')
