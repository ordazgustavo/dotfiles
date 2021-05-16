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
vim.o.splitbelow = true
vim.o.splitright = true

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

vim.api.nvim_exec([[
  set undodir=~/.vim/undodir
  set undofile

  set shortmess+=c

  filetype plugin indent on
]], false)

-- Rust
vim.g.rustfmt_autosave = 1

-- NvimTree
vim.g.nvim_tree_lsp_diagnostics = true
vim.g.nvim_tree_icons = {
  git = {unstaged = "", staged = "", renamed = "", untracked = ""},
}
