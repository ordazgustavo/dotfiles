local icons = {
  diagnostics = {
    Error = '● ',
    Warn = '● ',
    Hint = '● ',
    Info = '● ',

    -- Error = " ",
    -- Warn = " ",
    -- Hint = " ",
    -- Info = " ",
  },
  git = {
    -- added = "● ",
    -- modified = "● ",
    -- removed = "● ",

    added = ' ',
    modified = ' ',
    removed = ' ',
  },
}
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
    opts = {
      view_options = {
        show_hidden = true,
      },
      preview = {
        min_width = { 120, 0.75 },
      },
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function(_, opts)
      require('oil').setup(opts)
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = {
          statusline = { 'lazy' },
          -- winbar = { "neo-tree" },
        },
        component_separators = '|',
        section_separators = '',
      },
      extensions = { 'lazy' },
      sections = {
        lualine_a = {
          {
            function()
              return ' '
            end,
            padding = 0,
          },
        },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'diff',
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },
          { 'filename', path = 0, symbols = { modified = '●', readonly = '', unnamed = '' } },
        },
        lualine_x = {
          { 'searchcount' },
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            function()
              return os.date('%H:%M', os.time())
            end,
          },
        },
        lualine_y = {
          { 'progress', separator = '', padding = { left = 1, right = 1 } },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return ' '
            end,
            padding = 0,
          },
        },
      },
    },
  },
}
