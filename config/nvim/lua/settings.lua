vim.o.syntax = 'on'  -- Enable syntax highlighting
vim.o.clipboard = 'unnamedplus' -- Allow copy/paste from anywhere
vim.o.cmdheight = 2
vim.o.hidden = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.timeoutlen = 1000
vim.o.termguicolors = true
vim.o.t_Co = '256'
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.errorbells = false
vim.o.showmode = false
vim.o.guifont = 'FuraCode NF:h17'
vim.o.mouse = 'a'
vim.o.colorcolumn = '80'
vim.o.ts = 4
vim.o.sw = 4

vim.bo.expandtab = true -- Convert tabs to spaces
vim.bo.smartindent = true

vim.wo.number = true -- Show line numbers
vim.wo.relativenumber = true -- Use relative line numbers
vim.wo.wrap = false -- Don't wrap lines
vim.wo.signcolumn = 'yes' -- Avoid text shift
vim.wo.scrolloff = 8

vim.g.netrw_browse_split = 2
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.cmd('set shortmess+=c')
vim.cmd('filetype plugin indent on')

-- Rust
vim.g.rustfmt_autosave = 1

--- Mappings

-- Set leader
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- barbar
vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', ':BufferClose<CR>', { noremap = true, silent = true })
