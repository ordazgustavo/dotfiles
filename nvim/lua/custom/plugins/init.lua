-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },

  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
    config = function(_, opts)
      require('illuminate').configure(opts)

      vim.keymap.set('n', ']r', function()
        require('illuminate').goto_next_reference(false)
      end, { desc = 'Go to next [R]eference' })
      vim.keymap.set('n', '[r', function()
        require('illuminate').goto_prev_reference(false)
      end, { desc = 'Go to prev [R]eference' })
    end,
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function(_, opts)
      require('oil').setup(opts)
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
}
