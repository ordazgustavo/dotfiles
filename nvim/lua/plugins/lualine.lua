local icons = {
  diagnostics = {
    Error = '● ',
    Warn = '● ',
    Hint = '● ',
    Info = '● ',
  },
  git = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
}

return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      theme = 'auto',
      globalstatus = true,
      disabled_filetypes = {
        statusline = { 'lazy' },
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
}
