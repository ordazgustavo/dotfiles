require 'options'
require 'keymaps'

local diagnostics = { 'Error', 'Warn', 'Hint', 'Info' }
for _, name in ipairs(diagnostics) do
  name = 'DiagnosticSign' .. name
  vim.fn.sign_define(name, { text = '● ', texthl = name, numhl = '' })
end

vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, source = 'if_many', prefix = '●' },
  severity_sort = true,
}

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup 'plugins'

-- vim: ts=2 sts=2 sw=2 et
