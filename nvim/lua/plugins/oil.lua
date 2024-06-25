return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    defualt_file_explorer = true,
    columns = { 'icon' },
    view_options = {
      show_hidden = true,
    },
    preview = {
      min_width = { 120, 0.75 },
    },
  },
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '<space>-', require('oil').toggle_float)
  end,
}
