return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      show_hidden = true,
    },
    preview = {
      min_width = { 120, 0.75 },
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
